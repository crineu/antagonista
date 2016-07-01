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
		result = "<p>Os restos do acampamento do MTST montado perto da casa de Michel</p><p>Temer, em São Paulo.</p><p>É lixo de todos os lados.</p><p><img src=\"https://cdn.oantagonista.net/uploads%2F1464010251131-image.jpeg\"></p>"
		crawled = Noticia.new("sample_old_with_image.html").html

		assert_equal result, crawled
	end


# versão nova revertida....
	def nao_mais_test_noticia_juca
		result = "<p>É balela que Romero Jucá, quando disse a Sérgio Machado sobre a necessidade de estancar a “sangria”, se referia à crise econômica e política.</p><p>Ele claramente falou da Lava Jato, da necessidade de parar a operação. </p>"
		crawled = Noticia.new("posts_a-balela-de-juca.html").html

		assert_equal result, crawled
	end

	def nao_mais_test_noticia_cemig
		result = "<p>A Cemig da gestão Fernando Pimentel abriga ao menos dois enrolados na Operação Acrônimo:</p><p>O presidente Mauro Borges, que ficou encarregado de manter o esquema de corrupção no MDIC após a saída de Pimentel.</p><p>O outro é o diretor de Gás Felipe Torres do Amaral, sobrinho de Pimentel que recebeu propina do governador para abrir uma franquia do restaurante Madero, como relatou o delator Benedito de Oliveira, o Bené.</p><p>Questionada por O Antagonista, a Cemig disse apenas que “não vai comentar o assunto”.</p>"
		crawled = Noticia.new("posts_cemig-de-pimentel-e-um-acronimo.html").html

		assert_equal result, crawled
	end

end
