class Booking < ApplicationRecord
  belongs_to :brain
  belongs_to :user

  validates :length_of_time, presence: true
  validates :start_date, presence: true
  validates :status, presence: true
end
