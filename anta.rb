require 'oga'
require 'open-uri'

URL = "http://www.oantagonista.com"

module Crawler
    def self.crawl(path)
        begin
            # return Nokogiri::HTML(open(URL + path).read, nil, "UTF-8")
            html = open(URL + path, open_timeout: 10, redirect: false).read
            return Oga.parse_html(html)
        rescue OpenURI::HTTPError
            return ""
        end
    end
end


class Pagina
    attr_reader :html

    def initialize(pagina = 1)
        @html = []
        page = Crawler.crawl("/pagina/#{pagina}")

        artigos = page.xpath("//article")
        artigos.each do |article|
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

        page = Crawler.crawl(path)

        # carrega o conteúdo da notícia, dentro de um elemento
        # <div class="the-content-text"...
        conteudo = page.xpath("//div[@class='the-content-text']")

        @html = conteudo.first.to_xml
    end
end
