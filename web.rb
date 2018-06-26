require 'sinatra'
require_relative 'lib/crawler.rb'
require_relative 'lib/parser.rb'

use Rack::Deflater

ENV['version'] = "3.6.2"

# ROUTES
get '/:num?/?' do
  page_requested = params[:num].to_i
  page_requested = 1 if page_requested < 1

  @news     = NewsListCleaner.clean(WebCrawler.crawlAntaNewsList(page_requested))
  @proxima  = page_requested + 1
  @anterior = page_requested == 1 ? nil : page_requested - 1

  erb :main
end

get '/:categoria/:titulo/?' do
  SingleNewsCleaner.clean(WebCrawler.crawlAntaSingleNews(params[:categoria], params[:titulo]))
end
