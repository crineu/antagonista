require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = "http://www.oantagonista.com/"

class Anta

    attr_reader :html

    def initialize
        begin
            @page = Nokogiri::HTML(open(URL).read, nil, "UTF-8")
            @html = []

            articles = @page.xpath("//article")
            articles.each do |article|
                path = article.css("a")[0]['href']
                @html << "<h2>#{article.css('h3').text}</h2>" + Noticia.new(path.to_s).html
            end

        rescue OpenURI::HTTPError => httpe
            puts "HTTPError maldito"
            return
        end
    end

end


class Noticia
    attr_reader :html

    def initialize(path)
        page = Nokogiri::HTML(open(URL + path).read, nil, "UTF-8")
        @html = page.xpath("//div[@class='l-main-right']/p").to_s   # carrega o conteúdo da notícia
    end
end
