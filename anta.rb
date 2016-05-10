require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Anta
    @@url = "http://www.oantagonista.com/"

    attr_reader :html

    def initialize
        begin
            @page = Nokogiri::HTML(open(@@url).read, nil, "UTF-8")
            @html = []

            articles = @page.xpath("//article")
            articles.each do |article|
                path = article.css("a")[0]['href']
                @html << "<h2>#{article.css('h3').text}</h2>" + extrai_conteudo_noticia(path.to_s)
            end

        rescue OpenURI::HTTPError => httpe
            puts "HTTPError maldito"
            return
        end
    end

    def extrai_conteudo_noticia(path)
        html = Nokogiri::HTML(open(@@url + path).read, nil, "UTF-8")
        html.xpath("//div[@class='l-main-right']/p").to_s
    end


    def conteudo_noticias(links)
        threads = []
        result = []

        links.each do |news|
            threads << Thread.new(episode) do |ep|
                result << episode.populate!
            end
        end
        threads.each {|t| t.join}
        result
    end

end
