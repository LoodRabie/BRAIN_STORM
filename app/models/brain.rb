class Brain < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :renting_users, through: :bookings, source: :user

  validates :name, presence: true
  validates :characteristics, presence: true
  validates :description, presence: true
  validates :specialities, presence: true
end
