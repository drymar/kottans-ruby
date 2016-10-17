class DestroyMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    MessageDestroyer.new.destroy_message(message_id)
  end
end
