require 'rubygems'
require 'sinatra'

get '/' do 
  erb 'Главная типо страница'
end

get '/event' do
  erb 'Тут типо тусы'
end

get '/contacts' do
  erb 'Тут типо наши контакты'
end

get '/proba' do
  erb 'тут типо испытываем всякую хрень'
end
