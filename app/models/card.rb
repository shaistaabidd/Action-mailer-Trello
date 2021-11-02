class Card < ApplicationRecord
  belongs_to :list
  
  
  enum status: {New: 0, Pending: 1, Complete: 2}
  validates :status, inclusion: { in: statuses.keys }
  validates :name, :status, :presence => true,
                         :length => {:maximum => 25},
                         :format => {:with => /[a-zA-Z]/}
end
