class CardJob < ApplicationJob
  queue_as :default

  def perform(card)
    #if card.present?
      UserMailer.reminder.deliver_now
    #end  
    # Do something later
  end
end
