class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, timeout_in: 2.hours

  attribute :confirmed_at, :datetime

  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true

  def send_confirmation_notification?
    false
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name email confirmed_at] # Add other searchable attributes as needed
  end

  def self.ransackable_associations(auth_object = nil)
    # Optionally, you can define associations that are searchable
    []
  end

  def is_confirm
    confirmed_at
  end
end
