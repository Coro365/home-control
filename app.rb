require 'sinatra'

require "./dns_cancel.rb"
require "./serial_sender.rb"
require "./timer.rb"


#serialInstance = instance()


get '/' do

    erb :index
end

get '/standOn' do
	serialSend(serialInstance,1)

    redirect '/'
end

get '/standOff' do
	serialSend(serialInstance,2)

    redirect '/'
end

get '/roomOn' do
	serialSend(serialInstance,3)

	redirect '/'
end

get '/roomOff' do
	serialSend(serialInstance,4)

	redirect '/'
end

get '/timer/:action' do |a|
	@action = a

	erb :timer
end


post '/timeset/:action' do |a|
	action = a
	hour = params[:hour]
	minit = params[:minit]

	print("#{action} after #{hour}hour #{minit}minit\n")

	timer_thread = Thread.new do
		t = Timer.new
		t.timer(action, t.to_sec(hour, minit))
	end

	redirect '/'
end

post '/timeset1/:action' do |a|
	action = a
	limit_time = params[:time]


	print("#{action} at #{limit_time}\n")

	timer_thread = Thread.new do
		t = Timer.new
		t.timer(action, t.to_relative_time(limit_time))
	end

	redirect '/'
end


