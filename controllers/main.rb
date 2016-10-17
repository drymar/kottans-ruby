enable :sessions
use Rack::Flash

get '/' do
  cookies[:user] = nil
  @message = Message.new
  erb :main
end

post '/messages' do
  @message = Message.new(params[:message])
  if @message.save
    flash.now[:notice] = 'Message created!'
    erb :'messages/created'
  else
    flash.now[:notice] = 'Error!'
    erb :main
  end
end

get '/message/:token' do
  if authorized?
    show_message
  else
    authorize!
  end
end

post '/message/authenticate' do
  if message.authenticate(params[:password])
    cookies[:user] = message.password_digest
    redirect to("/message/#{message.token}")
  else
    flash[:notice] = 'Wrong password, please try again'
    redirect to("/message/#{message.token}")
  end
end

helpers do
  def message
    @message ||= Message.find_by(token: params[:token])
  end

  def authorize!
    if message.nil?
      flash[:notice] = 'Does not exist!'
      redirect to('/')
    end
    erb :'/messages/authorize'
  end

  def authorized?
    cookies[:user] == message.password_digest ? true : false
  end

  def show_message
    if message.nil?
      flash[:notice] = 'Does not exist!'
      redirect to('/')
    end
    if message.view_limit?
      message.delete
      flash[:notice] = 'Message has been destroyed!'
      redirect to('/')
    else
      message.increment!(:visit_number, by = 1)
      @body = Encryptor.new(message.body, message.password_digest).decrypt
      erb :'messages/show'
    end
  end
end
