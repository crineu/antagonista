require 'sinatra'
require './anta'

get '/' do
    @html = Anta.new.html
    erb :anta
end

