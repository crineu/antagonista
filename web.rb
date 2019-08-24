# frozen_string_literal: true
require 'sinatra'
require 'anta'

use Rack::Deflater

# Headlines only
get '/' do
  # TODO fazer a lista de manchetes
  redirect '/1'
end


# Full news by page
get '/:page_number' do
  anta = Anta::ByPage.new(params[:page_number].to_i)

  @next_page = anta.page + 1
  @prev_page = anta.page - 1 if anta.page > 1
  @news_list = anta.news_list

  erb :main
end


# Single news
get '/' do

end