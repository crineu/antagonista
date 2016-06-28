require 'minitest/autorun'
require File.dirname(__FILE__) + "/../anta.rb"

module Crawler
	def self.crawl(file_name)
		path = File.expand_path("../#{file_name}", __FILE__)
		return Nokogiri::HTML(IO.read(path))
	end
end

class TestAnta < MiniTest::Test

	def test_noticia
		result = "<p>É balela que Romero Jucá, quando disse a Sérgio Machado sobre a necessidade de estancar a “sangria”, se referia à crise econômica e política.</p><p>Ele claramente falou da Lava Jato, da necessidade de parar a operação. </p>"
		crawled = Noticia.new("post_a-balela-de-juca.html").html

		assert_equal result, crawled
	end

end
