class Profile < ApplicationRecord
    belongs_to :user 
    has_one_attached :avatar
    enum gender: { Female: 0, Male: 1 }

    validates :name, length: { minimum: 2 }, allow_blank: true
    validates :address, length: { minimum: 10 }, allow_blank: true
    validates :phone, length: { minimum: 10 }, allow_blank: true

    def self.ransackable_attributes(auth_object = nil)
        %w[name]
    end
end
  