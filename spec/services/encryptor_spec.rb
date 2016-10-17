require_relative '../spec_helper'

describe Encryptor do
  let(:message) {'hello_world' }
  let(:password) { '1234' }
  let(:encryptor) { Encryptor.new(message, password) }
  let(:encrypted_data) { encryptor.encrypt }
  let(:decrypted_message) { Encryptor.new(encrypted_data, password).decrypt }

  it 'should be initialized with params' do
    expect { encryptor }.to_not raise_error
  end

  it 'should raise error without params' do
    expect { Encryptor.new }.to raise_error(ArgumentError)
  end

  it 'should encrypt messages by password' do
    expect(encryptor.encrypt).to eq(encrypted_data) 
  end

  it 'should decrypt encrypted data to origin' do
    expect(Encryptor.new(encrypted_data, password).decrypt).to eq(decrypted_message)
  end
end
