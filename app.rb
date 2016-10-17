require 'sinatra'
require "sinatra/cookies"
require 'rack-flash'
require 'sinatra/activerecord'
require 'bcrypt'
require 'aescrypt'
require 'sidekiq'
require 'sidekiq/api'

require_relative 'models/message'
require_relative 'controllers/main'
require_relative 'services/encryptor'
require_relative 'services/message_destroyer'
require_relative 'workers/destroy_message_worker'

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
$redis = Redis.new(url: uri)
