require 'sinatra'
require './anta'

ENV['version'] ||= `git describe --always --tags`

get '/' do
    redirect '/pagina/1'
end

get '/pagina/:num' do
    @html = Pagina.new(params[:num]).html
    erb :main
end

get '/posts/:id' do
    Noticia.new("/posts/#{params[:id]}").html
end
