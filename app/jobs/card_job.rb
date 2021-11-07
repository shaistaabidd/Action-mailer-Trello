class CardJob < ApplicationJob
  queue_as :default

  def perform(to,from,card)
    #binding.irb
    #if card.present?
      # UserMailer.reminder.deliver_now
    #end 
    return if card.mail_sent?
    return if card.deadline > Time.now
    card.send_email!(to,from,card)
    #UserMailer.reminder(to,from,card).deliver_now
    # Do something later
  end
end
