require 'sinatra'
require './anta'

ENV['version'] ||= "2.3.0"

# ROUTES
get '/:num?/?' do
    page_requested = params[:num].to_i
    page_requested = 1 if page_requested < 1

    @html     = Pagina.new(page_requested).html
    @proxima  = page_requested + 1
    @anterior = page_requested == 1 ? nil : page_requested - 1

    erb :main
end

get '/:categoria/:titulo/?' do
    Noticia.new("/#{params[:categoria]}/#{params[:titulo]}").html
end
