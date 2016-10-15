require 'sinatra'
require 'sinatra/activerecord'
require './models/message'
require 'rack-flash'

enable :sessions
use Rack::Flash

get '/' do
  db_time = database.connection.execute('SELECT CURRENT_TIMESTAMP').first['now']
  request.logger.info("DB time is #{db_time}")
  erb :dashboard
end

post '/messages' do
  @message = Message.new(params[:message])
  if @message.save
    flash[:notice] = 'Saved!'
    redirect_to '/'
  else
    erb :'dashboard'
  end
end

get '/message/:token' do
  @message = Message.find_by(token: params[:token])
  erb :'messages/show'
end