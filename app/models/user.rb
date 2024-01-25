class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, timeout_in: 2.hours

  attribute :confirmed_at, :datetime

  has_one :profile

  validates :email, presence: true, uniqueness: true

  def send_confirmation_notification?
    false
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name email confirmed_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[profile] # Include other associations as needed
  end

  def is_confirm
    confirmed_at
  end
end
