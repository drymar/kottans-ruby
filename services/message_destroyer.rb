class MessageDestroyer
  def destroy_message(id)
    Message.find(id).destroy
  end
end
