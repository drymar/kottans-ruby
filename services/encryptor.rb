class Encryptor
  attr_reader :message, :password

  def initialize(message, password)
    @message = message
    @password = password
  end

  def encrypt
    encrypt_message
  end

  def decrypt
    decrypt_message
  end

  private

  def encrypt_message
    AESCrypt.encrypt(message, password)
  end

  def decrypt_message
    AESCrypt.decrypt(message, password)
  end
end
