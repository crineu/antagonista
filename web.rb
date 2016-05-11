require 'sinatra'
require './anta'

get '/' do
    @html = Anta.new.html
    erb :anta
end

get '/posts/:id' do
    Noticia.new("/posts/#{params[:id]}").html
end
