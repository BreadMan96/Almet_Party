require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord'

def init_db
  @db = SQLite3::Database.new 'almet_party_test.db'
  @db.results_as_hash = true
end

before do
  init_db
end

configure do
  init_db
  @db.execute 'CREATE TABLE IF NOT EXISTS 
    "Party" 
    ( 
      ID INTEGER PRIMARY KEY AUTOINCREMENT, 
      Name TEXT, 
      Phone INTEGER,
      Email TEXT,
      Party_name TEXT,
      Description TEXT,
      Location TEXT,
      Date_Stamp_Start TEXT,
      Date_Stamp_Finish TEXT,
      Guests TEXT,
      Age_Plus TEXT,
      Created_Date DATE
    )'

    @db.execute 'CREATE TABLE IF NOT EXISTS 
    "Comments" 
    ( 
      ID INTEGER PRIMARY KEY AUTOINCREMENT, 
      Name TEXT, 
      Comment TEXT,
      Created_Date DATE,
      Event_id INTEGER
    )'
end

#============================================================================

get '/' do 
  erb :index
end

#============================================================================

post '/' do
  @fio = params[:fio]
  @phone = params[:phone]
  @email = params[:email]
  @party_name = params[:party_name]
  @description = params[:description]
  @location = params[:location]
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

  @db.execute 'insert into Party (Name, Phone, Email, Party_name, Description, Location, Date_Stamp_Start, Date_Stamp_Finish, Guests, Age_Plus, Created_Date) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime())', [@fio, @phone, @email, @party_name, @description, @location, @date_stamp_start, @date_stamp_finish, @num_guests, @age_plus]

  erb :success_event
end

#============================================================================

get '/event' do
  @list_two = @db.execute 'select * from Party order by id desc'  

  @success = 'Все доступные встречи!'
  erb :event
end

#============================================================================

get '/event/:event_id' do
  # Получаем переменную из url-a
  event_id = params[:event_id]

  #Получаем список постов (в нашем случае только один пост по id)
  list_three = @db.execute 'select * from Party where id = ?', [event_id]

  #Выбираем этот один пост в переменную @row
  @row = list_three[0]

  #Получаем комментарии для поста
  @comment_for_event = @db.execute 'select * from Comments where Event_id = ? order by id', [event_id]

  erb :event_details
end

#============================================================================

post '/event/:event_id' do
  # Получаем переменную из url-a
  event_id = params[:event_id]
  username = params[:username]
  comment = params[:comment]

  @db.execute 'insert into Comments (Name, Comment, Created_Date, Event_id) values (?, ?, datetime(), ?)', [username, comment, event_id]

  redirect to('/event/' + event_id)
end

#============================================================================

get '/contacts' do
  erb :contacts
end

#============================================================================

get '/test' do
  erb :test
end

