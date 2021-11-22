class Product < ApplicationRecord

  has_many :prices, dependent: :destroy

  validates :name, 
  :presence => true, :uniqueness => true
end
