require 'nokogiri'
require 'open-uri'

URL = "http://www.oantagonista.com"

module Crawler
    def self.crawl(path)
        begin
            html = Nokogiri::HTML(open(URL + path).read, nil, "UTF-8")
        rescue OpenURI::HTTPError => httpe
            html = ""
        end
        html
    end
end


class Pagina
    attr_reader :html

    def initialize(pagina: 1)
        @html = []
        @page = Crawler.crawl("/pagina/#{pagina}")

        artigos = @page.xpath("//article")
        artigos.each do |article|
            data = {}
            data[:path]      = article.css("a")[0]['href']
            data[:full_path] = url + data[:path]
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
        p_tags = page.xpath("//article/p") # carrega o conteúdo da notícia
        # p_tags.pop if p_tags.last.children.first.name == 'br' # remove último <p> se for <br>
        p_tags.pop if p_tags.last.content.empty? # remove último <p> se for <br>
        @html = p_tags.to_s
    end
end
