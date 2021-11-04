class Card < ApplicationRecord
  belongs_to :list
  
  
  enum status: {New: 0, Pending: 1, Complete: 2}
  
  validates :status, inclusion: { in: statuses.keys }
  validates :name, :status, :presence => true,
                         :length => {:maximum => 25},
                         :format => {:with => /[a-zA-Z]/}
  

           
  after_save_commit do
    if deadline_previously_changed?
      # CardJob.set(wait_until: 2.minute.from_now).perform_later(self)
      CardJob.set(wait_until: (self.deadline.strftime("  %M").to_i-Time.now.strftime("  %M").to_i).minutes.from_now).perform_later(self)
      
    end
  end
end
