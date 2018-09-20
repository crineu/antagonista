require 'sinatra'
require 'rack/test'
require 'json'

require_relative '../web.rb'

RSpec.describe "API oantagonista" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/api/v1/:categoria/:titulo' do 
    before :all do
      get '/api/v1/brasil/viva-toffoli'
    end

    it('response ok')       { expect(last_response).to be_ok }
    it('json content_type') { expect(last_response.content_type).to eq('application/json') }

    it 'right body content' do
      expect(JSON.parse(last_response.body)).to eq(
        '<p>Um empreiteiro comemorou o fato de Dias Toffoli ter determinado '\
        'o afastamento do promotor Eduardo Nepomuceno, que resolveu reabrir '\
        'o inquérito que apurava a construção do aeroporto da cidade de '\
        'Cláudio, durante a administração de Aécio Neves.</p>'
      )
    end
  end

  describe '/api/v1/wrong/path returns false' do 
    before :all do
      get '/api/v1/qualquer/uma_que_nao_existe'
    end

    it('response ok')       { expect(last_response).to be_ok }
    it('json content_type') { expect(last_response.content_type).to eq('application/json') }

    it 'false as body content' do
      expect(JSON.parse(last_response.body)).to be(false)
    end
  end


  describe '/api/v1/pagina/:num' do
    before :all do
      get '/api/v1/pagina/10'
      @news_list = JSON.parse(last_response.body)
    end

    it('response ok')       { expect(last_response).to be_ok }
    it('json content_type') { expect(last_response.content_type).to eq('application/json') }

    it 'list of news is ok' do
      expect(@news_list).to be_a(Array)
      expect(@news_list.length).to eq(6)
    end

    it 'sample news is ok' do
      news = @news_list.sample
      expect(news).to have_key("full_path")
      expect(news).to have_key("local_path")
      expect(news).to have_key("title")
      expect(news).to have_key("date")
    end
  end

end
