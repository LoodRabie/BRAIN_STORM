class Brain < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :characteristics, presence: true
  validates :description, presence: true
  validates :specialities, presence: true
  validates :available, inclusion: { in: [true, false] }
end
