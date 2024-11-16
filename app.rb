#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@date_time = params[:date_time]
	@barber = params[:barber]
	@color = params[:color]

	hh = { :username => 'Введите имя',
			:phone => 'Введите телефон',
			:date_time => 'Введите дату и время'}

	hh.each do |key, value|
		if params[key] == ''
			@error = hh[key]
			return erb :visit
		end
	end
	
	f = File.open './public/users.txt', 'a'
	f.write "Имя: #{@username}, телефон: #{@phone}, дата и время записи: #{@date_time}, парикмахер: #{@barber}, цвет: #{@color} \n"
	f.close

	erb :record
end

post '/record' do
	erb :visit
end

get '/admin' do
	erb :admin
end

post '/admin' do
	@login = params[:login]
	@password = params[:password]

	if @login == 'admin' && @password == 'secret'
		@user_file = File.open('./public/users.txt', 'r')
		erb :users
	else
		erb 'Некорректные логин или пароль'
	end
end
