require_relative '../spec_helper'

describe Message do
  let(:params) do
    {
    body: 'hello_world',
    password: '1234',
    token: SecureRandom.urlsafe_base64,
    visit_limit: 5,
    destroy_time: 1
    }
  end
  let(:message) { Message.new(params) }

  before :each do
    Message.delete_all 
  end

  it 'could initialize without params' do
    expect { Message.new }.to_not raise_error
  end

  describe 'Message can get params' do
    it 'body' do
      expect(message.body).to eq('hello_world')
    end

    it 'destroy time' do
      expect(message.destroy_time).to eq(1)
    end

    it 'visit limit' do
      expect(message.visit_limit).to eq(5)
    end

    it 'visit number' do
      expect(message.visit_number).to eq(0)
    end
  end

  describe 'Message can works with DB' do
    it 'can be saved' do
      message.save
      m = Message.find(message.id)
      expect(message).to eq(m)
    end

    it 'can be authorized by password' do
      m = message.authenticate('1234')
      expect(message).to eq(m)
    end
  end
end
