require 'nokogiri'
require 'open-uri'
require 'json'

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

    def initialize(pagina = 1)
        @html = []
        json = Crawler.crawl("/wp-json/apiantagonista/v1/postindex?page=#{pagina}")
        json = JSON.parse json

        json.each do |article|
            data = {}
            data[:path]      = article['link']
            data[:full_path] = article['shortlink']
            data[:title]     = article['title']
            data[:date]      = article['date']

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
