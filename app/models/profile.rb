class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessor :first_name, :last_name

  validates :home_address, presence: true
  validates :description, presence: true
  validate :first_and_last_name_blank

  def first_and_last_name_blank
    errors.add(:first_name, "can't be blank") unless self.first_name.present?
    errors.add(:last_name, "can't be blank") unless self.last_name.present?
  end
end
