require 'rubygems'
require 'nokogiri'
require 'open-uri'

URL = "http://www.oantagonista.com/"

class Pagina
    attr_reader :html

    def initialize(pagina = 1)
        begin
            @page = Nokogiri::HTML(open(URL + "/pagina/#{pagina}").read, nil, "UTF-8")
            @html = []

            artigos = @page.xpath("//article")
            artigos.each do |article|
                path =   article.css("a")[0]['href']
                titulo = article.css('h3').text
                html  = "<h2>#{titulo}</h2>"
                html += "<button action='#{path}'>carregar notícia</button>"\

                @html << html
            end

        rescue OpenURI::HTTPError => httpe
            puts "HTTPError..."
            @html = ""
            return
        end
    end

end


class Noticia
    attr_reader :html

    def initialize(path)
        begin
            page = Nokogiri::HTML(open(URL + path).read, nil, "UTF-8")
            @html = page.xpath("//div[@class='l-main-right']/p").to_s   # carrega o conteúdo da notícia
        rescue OpenURI::HTTPError => httpe
            puts "HTTPError..."
            @html = ""
            return
        end
    end
end
