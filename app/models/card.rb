class Card < ApplicationRecord
  belongs_to :list
  
  validates :name, :status, :presence => true,
                         :length => {:maximum => 25},
                         :format => {:with => /[a-zA-Z]/}
end
