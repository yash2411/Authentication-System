class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:login]

  validates :mobileno,
  :presence => true,
  :uniqueness => true,
  if: :check_mobile_no


  attr_accessor :login

  def login=(login)
    @login = login
  end

  def login
    @login || self.mobileno || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["mobileno = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  private

  def check_mobile_no
    if self.mobileno.to_s.size != 10
      self.errors[:base] << "Invalid mobile number"
      return false
    end
  end

end

