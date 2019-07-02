# frozen_string_literal: true
module NewsListCleaner
  def self.clean(bloated_html)
    list = []
    articles = bloated_html.xpath('//article')
    articles.each do |article|
      next if article.at_xpath('./div/a/@data-link').nil?   # remove falsas notícias
      data = {}
      data[:full_path]  = article.at_xpath('./div/a/@data-link').value
      data[:title]      = article.at_xpath('./div/a/@data-title').value
      data[:date]       = article.at_xpath('./div/a/span/time/@datetime').value
      list << data
    end
    list.reverse  # older up, newer at bottom
  end
end

module SingleNewsCleaner
  def self.clean(bloated_html)
    bloated_html
      .at_xpath('//div[@id="entry-text-post"]')    # carrega conteúdo da notícia
      .children
      .select { |c| c.class == Oga::XML::Element } # filtra apenas elementos
      .select { |e| e.name  == "p"               } # do tipo "<p></p>"
      .map(&:text)                                 # extrai o texto interno
      .map(&:strip)                                # remove espaços
      .reject { |e| e.nil? || e.empty? }           # e elimina entradas vazias
    rescue NoMethodError => nme
      p nme
      false
  end
end
