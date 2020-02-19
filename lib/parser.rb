# frozen_string_literal: true

# news_hash = {
#   full_path:  'https://www.oantagonista.com/[tag]/[name]/'
#   title:      '[title]'
#   date:       '[YYYY-mm-dd HH:MM]'
#   content:    '[news content]'
# }
module Cleaner

  module NewsList
    def self.clean(bloated_html)
      list = []
      articles = bloated_html.xpath('//article')
      articles.each do |article|
        next if article.at_xpath('./div/a/@data-link').nil?   # remove falsas notícias

        list << {
          full_path: article.at_xpath('./div/a/@data-link').value,
          title:     article.at_xpath('./div/a/@data-title').value,
          date:      article.at_xpath('./div/a/span/time/@datetime').value,
        }
      end
      list
    end
  end

  module SingleNews
    def self.clean(bloated_html)
      bloated_html
        .at_xpath('//div[contains(@class, "entry-content")]')  # carrega conteúdo da notícia
        .children
        .select { |e| e.class == Oga::XML::Element } # filtra apenas elementos
        .select { |e| e.name  == "p"               } # do tipo "<p></p>"
        .map(&:text)                                 # extrai o texto interno
        .map(&:strip)                                # remove espaços
        .reject { |e| e.nil? || e.empty? }           # e elimina entradas vazias
      rescue NoMethodError => nme
        puts "[notícia vazia] #{nme}"
        false
    end
  end

end
