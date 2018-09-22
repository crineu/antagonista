# frozen_string_literal: true
require 'sinatra'
require 'json'

require 'crawler'
require 'parser'

use Rack::Deflater

ENV['version'] = "3.9.3"



get '/:num?' do
  page_requested = params[:num].to_i
  page_requested = 1 if page_requested < 1

  # @news     = NewsListCleaner.clean(WebCrawler.crawlAntaNewsList(page_requested))
  @page      = page_requested
  @page_next = page_requested + 1
  @page_prev = page_requested - 1

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
