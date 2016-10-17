require_relative '../spec_helper'

describe 'Sinatra App' do
  include Rack::Test::Methods
  let(:message) do
    Message.new(
      body: 'hello_world',
      password: '1234',
      token: SecureRandom.urlsafe_base64,
      visit_limit: 5,
      destroy_time: 1
    )
  end
  let(:token) { message.token }

  def app
    Sinatra::Application
  end

  it 'displays home page' do
    get '/'
    expect(last_response.body).to include('Welcome')
  end

  it 'create new message' do
    post 'messages', message: message
  end

  it 'authorize you to view message' do
    post '/message/authenticate'
  end

  it 'displays message page' do
    get "/message/#{token}"
    expect(last_response.body).to include('')
  end
end
