# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Create 10 random users
users = []
10.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  users << user
end

# Create 10 random brains, each associated with a user
10.times do
  user = users.sample
  brain = Brain.create!(
    name: Faker::Science.element,
    characteristics: Faker::Lorem.sentence(word_count: 10),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    specialities: Faker::Lorem.sentence(word_count: 5),
    available: [true, false].sample,
    user: user
  )

  # Create bookings for the brain
  3.times do
    Booking.create!(
      brain: brain,
      user: users.sample,
      length_of_time: rand(1..30), # Random length of time
      start_date: Faker::Date.forward(days: 30), # Bookings within the next 30 days
      status: 'booked'
    )
  end
end

puts "Created 10 users with 10 brains each, and bookings for each brain."
