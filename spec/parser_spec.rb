require 'parser'
require 'crawler'

RSpec.describe Cleaner::NewsList do

  it 'shows list of news for page 10' do
    sample_element = {
      full_path: 'https://www.oantagonista.com/brasil/manter-lula-nas-pesquisas-e-estrategia-ou-estelionato/',
      title:     'Manter Lula nas pesquisas é estratégia ou estelionato?',
      date:      '2018-06-11 15:08:32'
    }

    news = Cleaner::NewsList.clean(
      Crawler::File.crawl(
        File.expand_path('pagina10.html', __dir__)
      )
    )

    expect(news).to be_instance_of Array
    expect(news.length).to eq 6
    expect(news).to include sample_element
  end

end


RSpec.describe Cleaner::SingleNews do

  it 'clean notícia 1' do
    expect(
      Cleaner::SingleNews.clean(
        Crawler::File.crawl(
          File.expand_path('brasil__a-balela-de-juca.html', __dir__)
        )
      )
    ).to eq(
      [
        'É balela que Romero Jucá, quando disse a Sérgio Machado sobre a necessidade de estancar'\
        ' a “sangria”, se referia à crise econômica e política.',
        'Ele claramente falou da Lava Jato, da necessidade de parar a operação.'
      ]
    )
  end

  it 'clean notícia 2' do
    expect(
      Cleaner::SingleNews.clean(
        Crawler::File.crawl(
          File.expand_path('brasil__confirmado-lula-sera-preso-na-segunda-feira-26.html', __dir__)
        )
      )
    ).to eq(
      [
        'O Antagonista acaba de confirmar com fontes do TRF-4 que o desembargador Gebran Neto'\
        ' colocará o último recurso de Lula em julgamento na segunda-feira 26.',
        'Como os embargos de declaração não alteram a sentença, a prisão do ex-presidente será confirmada'\
        ' e caberá a Sergio Moro a ordem final – que poderá sair no mesmo dia.'
      ]
    )
  end

  it 'clean notícia 3' do
    expect(
      Cleaner::SingleNews.clean(
        Crawler::File.crawl(
          File.expand_path('video__braga_netto_um_militar_na_casa_civil.html', __dir__)
        )
      )
    ).to eq(
      [
        'Nesta terça-feira, o general Walter Braga Netto tomou posse como novo ministro da Casa Civil.',
        'Segundo o presidente Bolsonaro, o general “é quase unanimidade, um homem inteligente,'\
        ' organizador e disciplinador”.',
        'O Antagonista+ preparou um vídeo com um breve perfil do mais novo ministro do governo Bolsonaro.',
        'Confira:'
      ]
    )
  end

  it 'clean notícia com tweet' do
    expect(
      Cleaner::SingleNews.clean(
        Crawler::File.crawl(
          File.expand_path('brasil__moro-sou-grato.html', __dir__)
        )
      )
    ).to eq(
      [
        'Após os atos deste domingo, Sergio Moro usou o Twitter para agradecer o'\
        ' apoio que recebeu das ruas.',
        '“Sou grato ao PR @jairbolsonaro e a todos que apoiam e confiam em nosso'\
        ' trabalho. Hackers, criminosos ou editores maliciosos não alterarão essas'\
        ' verdades fundamentais. Avançaremos com o Congresso, com as instituições'\
        ' e com o seu apoio”, disse.',
        '“Eu vejo, eu ouço, eu agradeço. Sempre agi com correção como juiz e agora'\
        ' como Ministro. Aceitei o convite para o MJSP para consolidar os avanços'\
        ' anticorrupção e combater o crime organizado e os crimes violentos.'\
        ' Essa é a missão. Muito a fazer.”'
      ]
    )
  end

  it 'clean notícia com vídeo youtube' do
    expect(
      Cleaner::SingleNews.clean(
        Crawler::File.crawl(
          File.expand_path('tv__resumao-antagonista-pimenta-na-lava-jato.html', __dir__)
        )
      )
    ).to eq(
      [
        "Felipe Moura Brasil resume a semana em vídeo.",
        "Assista."
      ]
    )


  end

  it '/wrong/path returns false' do
    expect(
      Cleaner::SingleNews.clean(
        Crawler::File.crawl(
          File.expand_path('noticia_false_mal_formada.html', __dir__)
        )
      )
    ).to be(false)
  end

end
