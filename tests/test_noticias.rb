require 'minitest/autorun'
require File.dirname(__FILE__) + "/../anta.rb"

module Crawler
	def self.crawl(file_name)
		full_path = File.expand_path("../#{file_name}", __FILE__)
		return Nokogiri::HTML(IO.read(full_path), nil, "UTF-8")
	end
end

class TestAnta < MiniTest::Test

	def test_noticia_velha_com_imagem
		expected = "<div class=\"the-content-text\">\n    " +
			"<p>Os restos do acampamento do MTST montado perto da casa de " +
			"Michel Temer, em São Paulo.</p>\n<p>É lixo de todos os lados.</p>\n<p>" +
			"<img src=\"https://cdn.oantagonista.net/uploads%2F1464010251131" +
			"-image.jpeg\"></p>\n    </div>"
		crawled = Noticia.new("lixo-de-todos-os-lados.html").html

		assert_equal expected, crawled
	end


	def test_noticia_nova_cdn_com_imagem
		expected = "<div class=\"the-content-text\">\n    <p>Em 21 de" +
			" junho de 2015, o blogueiro petista Eduardo Guimarães escreveu " +
			"o seguinte sobre Sérgio Moro:</p>\n<img src=\"https://cdn." +
			"oantagonista.net/uploads%2F1490118023444-IMG_4557.JPG\" " +
			"style=\"\" rel=\"\"><p>Isso é jornalismo?</p>\n    </div>"
		crawled = Noticia.new("os_delirios_de_um_psicopata.html").html

		assert_equal expected, crawled
	end

end
