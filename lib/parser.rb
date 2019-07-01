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
      .at_xpath('//div[@id="entry-text-post"]')             # carrega conteúdo da notícia
      .children.select { |c| c.class == Oga::XML::Element } # filtra apenas os elementos
      .map(&:to_xml)                                        # transforma em xml
      .join
    rescue NoMethodError
      false
  end
end
