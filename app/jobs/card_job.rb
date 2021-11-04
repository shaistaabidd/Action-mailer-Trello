class CardJob < ApplicationJob
  queue_as :default

  def perform(card)
    #if card.present?
      # UserMailer.reminder.deliver_now
    #end 
    #return if card.deadline > Time.current
    UserMailer.reminder.deliver_now
    # Do something later
  end
end
