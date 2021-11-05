class Card < ApplicationRecord
  belongs_to :list
  #acts_as_taggable  
  acts_as_taggable#_on #:tags
  enum status: {New: 0, Pending: 1, Complete: 2}
  
  validates :status, inclusion: { in: statuses.keys }
  validates :name, :status, :presence => true,
                         :length => {:maximum => 25},
                         :format => {:with => /[a-zA-Z]/}
  

           
  after_save_commit do
    if deadline_previously_changed?
      if self.status=="New" || self.status=="Pending" # CardJob.set(wait_until: 2.minute.from_now).perform_later(self)
        
        deadline_date=((self.deadline.strftime(" %a, %d %b %Y").to_date-Time.now.strftime(" %a, %d %b %Y").to_date).to_i)-1
        
        if deadline_date<-1
          UserMailer.over_due(User.find_by(username:self.username),self.list.board.user,self).deliver_now
          
        else
          
          if deadline_date == -1
            #deadline_date=0 
            UserMailer.reminder(User.find_by(username:self.username),self.list.board.user,self).deliver_now
                    
          end
          
          CardJob.set(wait_until: deadline_date.days.from_now).perform_later(User.find_by(username:self.username),self.list.board.user,self)
        end
      end
      
    end
  end
  def self.get_user_names
    User.where.not(username: nil).pluck(:username)
  end
end
