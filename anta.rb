require 'oga'
require 'open-uri'

URL = "http://www.oantagonista.com".freeze

module Crawler
    def self.crawl(url)
        begin
            # return Nokogiri::HTML(open(url).read, nil, "UTF-8")
            html = open(url, open_timeout: 10, redirect: false).read
            return Oga.parse_html(html)
        rescue OpenURI::HTTPError
            return ""
        end
    end
end


class Pagina
    attr_reader :html

    def initialize(page_number = 1)
        @html = []
        page = Crawler.crawl(URL + "/pagina/#{page_number}")

        articles = page.xpath("//article")
        articles.each do |article|
            data = {}
            data[:path]      = article.css("a")[0]['href']
            data[:full_path] = URL + data[:path]
            data[:title]     = article.css('h3').text
            data[:date]      = article.css('span.post-meta').text
            @html << data
        end
    end
end


class Noticia
    attr_reader :html

    def initialize(path)
        @html = ""

        page = Crawler.crawl(URL + path)

        # carrega o conteúdo da notícia, dentro de um elemento
        # <div class="the-content-text"...
        content = page.xpath("//div[@class='the-content-text']")

        @html = content.first.to_xml
    end
end
