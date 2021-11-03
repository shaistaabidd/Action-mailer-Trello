class CardJob < ApplicationJob
  queue_as :default

  def perform(card)
    UserMailer.reminder.deliver_now
      
    # Do something later
  end
end
