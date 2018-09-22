# frozen_string_literal: true
require 'sinatra'
require 'json'

require 'crawler'
require 'parser'

use Rack::Deflater

ENV['version'] = "3.9.5"


get '/:num?' do
  @page = [1, params[:num].to_i].max
  erb :main
end


# API ROUTES
get '/api/v1/pagina/:num' do
  content_type :json
  NewsListCleaner.clean(
    WebCrawler.crawlAntaNewsList(
      params[:num].to_i
    )
  ).to_json
end

get '/api/v1/:categoria/:titulo/?' do
  content_type :json
  SingleNewsCleaner.clean(
    WebCrawler.crawlAntaSingleNews(
      params[:categoria], params[:titulo]
    )
  ).to_json
end
