require 'sinatra'
require './anta'

ENV['version'] ||= `git describe --always --tags`
enable :sessions

# HELPERS
helpers do
    def pagina_atual
        return session[:page] if session[:page]
        return 0
    end
end

# ROUTES
get '/' do
    redirect '/pagina/1'
end

get '/pagina/:num' do
    session[:page] = params[:num].to_i
    @html = Pagina.new(params[:num]).html
    erb :main
end

get '/proxima/?' do
    redirect "/pagina/#{pagina_atual + 1}"
end

get '/anterior/?' do
    proxima_pagina = (pagina_atual - 1)
    proxima_pagina = 1 if proxima_pagina < 1
    redirect "/pagina/#{proxima_pagina}"
end

get '/posts/:id' do
    Noticia.new("/posts/#{params[:id]}").html
end
