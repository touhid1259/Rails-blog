class User < ActiveRecord::Base

  has_one :profile

  attr_accessor :confirm_password

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email_address, :presence => true
  validates :email_address, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :name, :presence => true
  validates :name, :uniqueness => true
  validates :password_digest, :presence => true
  validate :confirm_pass_match

  def confirm_pass_match
    errors.add(:confirm_password, "Passwords don't match") unless self.password_digest == self.confirm_password
  end

  def authenticate (password)
    self.password_digest == password
  end
end
