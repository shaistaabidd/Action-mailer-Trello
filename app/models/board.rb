class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy
  
  validates :name, :presence => true,
                         :length => {:maximum => 25},
                         :format => {:with => /[a-zA-Z]/}
end
