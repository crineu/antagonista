require 'sinatra'
require 'sass'
require './anta'

ENV['version'] ||= "0." + `git rev-list --count HEAD`
enable :sessions
set :session_secret, '*f0999c#te764e0ab33c0c80bacf5e7d40(2^B234'

# HELPERS
helpers do
    def pagina_atual
        return session[:page] if session[:page]
        return 0
    end
end

# ROUTES
get '/css/main.css' do
    scss :main, :style => :compressed
end

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
