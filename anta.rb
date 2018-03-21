require 'oga'
require 'open-uri'

URL = "https://www.oantagonista.com"

module Crawler
    def self.crawl(path)
        begin
            html = Oga.parse_html(open(URL + path).read)
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
        page = Crawler.crawl("/pagina/#{pagina}")

        artigos = page.xpath("//article")
        artigos.each do |article|
            next if article.at_xpath("./div/a/@data-link").nil?
            data = {}
            data[:full_path]  = article.at_xpath("./div/a/@data-link").value
            data[:local_path] = data[:full_path].split('gonista.com/').last
            data[:title]      = article.at_xpath("./div/a/@data-title").value
            data[:date]       = article.at_xpath("./div/a/span/time/@datetime").value
            @html << data
        end
    end
end


class Noticia
    attr_reader :html

    def initialize(path)
        @html = ""

        page = Crawler.crawl(path)
        elements_set = page.at_xpath("//div[@id='entry-text-post']") # carrega o conteúdo da notícia

        @html = elements_set.children.select{ |c| c.class == Oga::XML::Element }.map{ |e| e.to_xml }.join
    end
end
