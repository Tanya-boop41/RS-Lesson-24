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

	if @username == ''
		@error = 'Введите имя'
		return erb :visit
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
