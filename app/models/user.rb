class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :owned_brain, class_name: 'Brain', dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :rented_brains, through: :bookings, source: :brain

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
