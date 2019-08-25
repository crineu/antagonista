# frozen_string_literal: true
require 'sinatra'
require 'anta'

use Rack::Deflater

# Headlines only
get '/' do
  @headlines = Anta::Headlines.new.list

  erb :headlines
end


# Full news by page
get '/:page_number' do
  anta = Anta::ByPage.new(params[:page_number].to_i)

  @next_page = anta.page + 1
  @prev_page = anta.page - 1 if anta.page > 1
  @news_list = anta.list

  erb :news
end


# Single news
get '/' do

end