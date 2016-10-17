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

  after :all do
    Message.delete_all 
  end

  it 'could initialize without params' do
    expect { Message.new }.to_not raise_error
  end

  it 'is invalid without a body' do
    expect(message).to be_valid
  end

  context 'Message can get params' do
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

  context 'Message can works with DB' do
    it 'raises error if saved without params' do
      new_message = Message.new
      expect { new_message.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'can be saved' do
      expect {message.save}.to change { Message.count }.by(1)
    end

    it 'can be authorized by password' do
      m = message.authenticate('1234')
      expect(message).to eq(m)
    end

    it 'should check view limit' do
      message.save
      m = Message.last
      expect(m.view_limit?).to be false
    end
  end
end
