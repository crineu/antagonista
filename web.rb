require 'sinatra'
require 'sass'
require './anta'

ENV['version'] ||= "1.74"

# ROUTES
get '/css/main.css' do
    scss :main, :style => :compressed
end

get '/:num?/?' do
    page_requested = params[:num].to_i
    page_requested = 1 if page_requested < 1

    @html = Pagina.new(page_requested).html
    @proxima  = page_requested + 1
    @anterior = page_requested == 1 ? nil : page_requested - 1

    erb :main
end

get '/posts/:id' do
    Noticia.new("/posts/#{params[:id]}").html
end
