require 'nokogiri'
require 'open-uri'
require 'json'

URL = "http://www.oantagonista.com"

module Crawler
    def self.crawl(path)
        begin
            html = open(URL + path).read
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
            data[:date]      = article['date'].gsub(/T|Z/, ' ')

            @html << data
        end
    end
end


class Noticia
    attr_reader :html

    def initialize(path)
        @html = ""

        page = Nokogiri::HTML(Crawler.crawl(path), nil, "UTF-8")
        p_tags = page.xpath("//article/p") # carrega o conteúdo da notícia
        p_tags.pop if p_tags.last.text.gsub(/[[:space:]]/, '').empty? # remove último <p> se for vazio

        @html = p_tags.to_s
    end
end
