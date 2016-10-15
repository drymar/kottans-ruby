require 'sinatra'
require 'sinatra/activerecord'

get '/' do
  db_time = database.connection.execute('SELECT CURRENT_TIMESTAMP').first['now']
  request.logger.info("DB time is #{db_time}")
  erb :dashboard
end