require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord'

def get_db
  return SQLite3::Database.new 'almet_party_test.db'
end

configure do
  db = get_db  #получаем объект базы данных
  db.execute 'CREATE TABLE IF NOT EXISTS 
    "Party" 
    ( 
      ID INTEGER PRIMARY KEY AUTOINCREMENT, 
      Name TEXT, 
      Phone INTEGER,
      Email TEXT,
      Description TEXT,
      Date_Stamp_Start TEXT,
      Date_Stamp_Finish TEXT,
      Guests TEXT,
      Age_Plus TEXT
    )'
end


get '/' do 
  erb :index
end

post '/' do
  @fio = params[:fio]
  @phone = params[:phone]
  @email = params[:email]
  @description = params[:description]
  @date_stamp_start = params[:date_stamp_start]
  @date_stamp_finish = params[:date_stamp_finish]
  @num_guests = params[:num_guests]
  @age_plus = params[:age_plus]

  if @description.size < 10
    @error = 'Описание должно быть больше 10 символов. Пожалуйста, опишите Вашу встречу подробнее!'
    return erb :index
  end

  save = File.open './public/actors.txt', 'a'
  save.write "Имя и Фамилия: #{@fio}\nНомер телефона: #{@phone}\nПочта: #{@email}\nОписание мероприятия: #{@description}\nКол-во гостей: #{@num_guests}\nВозраст: #{@age_plus}\n===================\n"
  save.close

  db = get_db
  db.execute 'insert into Party (Name, Phone, Email, Description, Date_Stamp_Start, Date_Stamp_Finish, Guests, Age_Plus) values (?, ?, ?, ?, ?, ?, ?, ?)', [@fio, @phone, @email, @description, @date_stamp_start, @date_stamp_finish, @num_guests, @age_plus]

  erb :success_event
end

get '/event' do
  db = get_db
  db.results_as_hash = true
  @list = db.execute 'select * from Party order by id desc' #получаем данные из таблицы Party   

  @success = 'Все доступные встречи!'
  erb :event
end


get '/contacts' do
  erb :contacts
end


get '/test' do
  erb :test
end

