require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

get '/' do 
  erb :index 
end

get '/event' do
  erb 'Тут типо тусы'
end

get '/contacts' do
  erb 'Тут типо наши контакты asddsa'
end

get '/proba' do
  erb :proba
end
