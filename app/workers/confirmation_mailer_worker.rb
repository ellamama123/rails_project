class ConfirmationMailerWorker
    include Sidekiq::Worker
  
    def perform(user_id)
      user = User.find_by(id: user_id)
      user.send_confirmation_instructions
    end
  end
  