require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

get '/' do 
  erb :index 
end

get '/event' do
  erb :event
end

get '/contacts' do
  erb :contacts
end

get '/proba' do
  erb :proba
end
