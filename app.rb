require 'sinatra'
require 'sinatra/activerecord'
require "sinatra/cookies"
require 'rack-flash'
require 'bcrypt'
require 'aescrypt'
require 'sidekiq'
require 'redis'

require_relative 'models/message'
require_relative 'controllers/main_controller'
require_relative 'services/encryptor'
require_relative 'workers/destroy_message_worker'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDISCLOUD_URL"] }
end

uri = URI.parse(ENV["REDISCLOUD_URL"] || "redis://localhost:6379/" )
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
