class User < ApplicationRecord
  rolify
  attr_accessor :login
  after_create :assign_default_role
  #before_commit :set_route
  
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
  def active_for_authentication?
    super && !deactivated
  end
  # def set_route
  #   if user.has_role? :admin
  #     redirect_to admin_index_path #, as: :root
  #   else
  #     redirect_to home_index_path
  #   end
  # end

  after_create do
    customer=Stripe::Customer.create(email: self.email)
    p customer
    update(stripe_customer_id:customer.id)
  end
end
