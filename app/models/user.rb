class User < ApplicationRecord
  rolify
  attr_accessor :login
  after_create :assign_default_role

  
  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  
  
  validates :username, 
    :presence => true, :uniqueness => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username) = :value OR lower(email) = :value",
      { value: login.strip.downcase}]).first
  end

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
