class Brain < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy
  has_many :renting_users, through: :bookings, source: :user


  validates :name, presence: true
  validates :characteristics, presence: true
  validates :description, presence: true
  validates :specialities, presence: true
  validates :available, inclusion: { in: [true, false] }
  validates :location, presence: true
  has_one_attached :photo

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
