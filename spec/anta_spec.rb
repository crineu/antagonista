require File.dirname(__FILE__) + "/../anta.rb"

module Crawler
  def self.crawl(file_name)
    full_path = File.expand_path("../#{file_name}", __FILE__)
    return Oga.parse_html(IO.read(full_path))
  end
end

RSpec.describe Noticia do

  it "parse da notícia do jucá" do
    result = "<p>É balela que Romero Jucá, quando disse a Sérgio Machado sobre a necessidade de estancar a “sangria”, se referia à crise econômica e política.</p><p>Ele claramente falou da Lava Jato, da necessidade de parar a operação. </p><p></p>"
    crawled = Noticia.new("brasil__a-balela-de-juca.html").html

    expect(crawled).to eq(result)
  end

  it "parse notícia da prisão" do
    result = "<p>O Antagonista acaba de confirmar com fontes do TRF-4 que o desembargador Gebran Neto colocará o último recurso de Lula em julgamento na segunda-feira 26.</p><p>Como os embargos de declaração não alteram a sentença, a prisão do ex-presidente será confirmada e caberá a Sergio Moro a ordem final – que poderá sair no mesmo dia.</p>"
    crawled = Noticia.new("brasil__confirmado-lula-sera-preso-na-segunda-feira-26.html").html

    expect(crawled).to eq(result)
  end

end
