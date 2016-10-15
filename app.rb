require 'sinatra'

get '/' do
  "#{['Hello', 'Hi', 'Hey'][rand(3)]} World!"
end