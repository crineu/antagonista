require 'parser'
require 'crawler'

RSpec.describe NewsListCleaner do

  it 'shows list of news for page 10' do
    sample_element = {
      full_path:  'https://www.oantagonista.com/brasil/manter-lula-nas-pesquisas-e-estrategia-ou-estelionato/',
      local_path: 'brasil/manter-lula-nas-pesquisas-e-estrategia-ou-estelionato/',
      title:      'Manter Lula nas pesquisas é estratégia ou estelionato?',
      date:       '2018-06-11 15:08:32'
    }
    news = NewsListCleaner.clean(FileCrawler.crawl(File.expand_path('pagina10.html', __dir__)))

    expect(news).to be_instance_of Array
    expect(news.length).to eq 6
    expect(news).to include sample_element
  end

end

RSpec.describe SingleNewsCleaner do

  it 'clean notícia jucá' do
    output = '<p>É balela que Romero Jucá, quando disse a Sérgio Machado sobre a necessidade de estancar'\
             ' a “sangria”, se referia à crise econômica e política.</p><p>Ele claramente falou da Lava '\
             'Jato, da necessidade de parar a operação. </p><p></p>'
    input = FileCrawler.crawl(File.expand_path('brasil__a-balela-de-juca.html', __dir__))
    expect(SingleNewsCleaner.clean(input)).to eq output
  end

  it 'clean notícia lula preso' do
    output = '<p>O Antagonista acaba de confirmar com fontes do TRF-4 que o desembargador Gebran Neto'\
             ' colocará o último recurso de Lula em julgamento na segunda-feira 26.</p><p>Como os'\
             ' embargos de declaração não alteram a sentença, a prisão do ex-presidente será confirmada'\
             ' e caberá a Sergio Moro a ordem final – que poderá sair no mesmo dia.</p>'
    input = FileCrawler.crawl(File.expand_path('brasil__confirmado-lula-sera-preso-na-segunda-feira-26.html', __dir__))
    expect(SingleNewsCleaner.clean(input)).to eq output
  end

  it 'clean notícia com vídeo youtube' do
    input = FileCrawler.crawl(File.expand_path('tv__resumao-antagonista-pimenta-na-lava-jato.html', __dir__))
    expect(SingleNewsCleaner.clean(input)).to be_falsey  # nil or false
  end

end
