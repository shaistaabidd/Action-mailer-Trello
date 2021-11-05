class List < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy
  
  validates :name, :presence => true,
                         :length => {:maximum => 25},
                         :format => {:with => /[a-zA-Z]/}
end
