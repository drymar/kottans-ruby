class DestroyMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    if Message.exists?(message_id)
      Message.find(message_id).destroy
    end
  end
end
