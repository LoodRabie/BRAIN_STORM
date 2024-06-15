# db/seeds.rb
require "open-uri"
# Clear existing data
puts "Clearing existing data..."

Booking.destroy_all
Brain.destroy_all
User.destroy_all

puts "Existing data cleared."

# Create users
puts "Creating users..."

users = User.create!([
  {
    email: "john.doe@example.com",
    password: "password123",
    password_confirmation: "password123",
    first_name: "John",
    last_name: "Doe"
  },
  {
    email: "jane.smith@example.com",
    password: "password123",
    password_confirmation: "password123",
    first_name: "Jane",
    last_name: "Smith"
  },
  {
    email: "alice.jones@example.com",
    password: "password123",
    password_confirmation: "password123",
    first_name: "Alice",
    last_name: "Jones"
  }
])

puts "Users created."

# Create brains
puts "Creating brains..."

brains = Brain.create!([
  {
    name: "Einstein Brain",
    characteristics: "Highly intelligent, creative thinker",
    description: "A brain known for its exceptional intelligence and creativity.",
    specialities: "Physics, Mathematics",
    user: users.first,
    available: true,
    latitude: -33.9249,
    longitude: 18.4241,
    location: "Table Mountain, Cape Town"

  },
  {
    name: "Tesla Brain",
    characteristics: "Inventive, innovative, ahead of its time",
    description: "A brain with a knack for inventing and innovation.",
    specialities: "Electricity, Engineering",
    user: users.second,
    available: false,
    latitude: -33.9279,
    longitude: 18.4174,
    location: "V&A Waterfront, Cape Town"
  },
  {
    name: "Curie Brain",
    characteristics: "Determined, methodical, groundbreaking",
    description: "A brain celebrated for groundbreaking scientific research.",
    specialities: "Chemistry, Physics",
    user: users.third,
    available: true,
    latitude: -34.0366,
    longitude: 18.4690,
    location: "Kirstenbosch National Botanical Garden, Cape Town"
  },
  {
    name: "Hawking Brain",
    characteristics: "Brilliant, insightful, theoretical",
    description: "A brain known for its profound contributions to theoretical physics.",
    specialities: "Cosmology, Quantum Mechanics",
    user: users.first,
    available: true,
    latitude: -33.9180,
    longitude: 18.4214,
    location: "Cape Town City Centre, Cape Town"
  },
  {
    name: "Darwin Brain",
    characteristics: "Observant, analytical, evolutionary",
    description: "A brain famous for its contributions to the theory of evolution.",
    specialities: "Biology, Natural Science",
    user: users.second,
    available: false,
    latitude: -34.0259,
    longitude: 18.6773,
    location: "Muizenberg Beach, Cape Town"
  },
  {
    name: "Franklin Brain",
    characteristics: "Pioneering, innovative, genetic",
    description: "A brain renowned for its role in discovering the structure of DNA.",
    specialities: "Genetics, Biochemistry",
    user: users.third,
    available: true,
    latitude: -33.9108,
    longitude: 18.4095,
    location: "Signal Hill, Cape Town"
  },
  {
    name: "Newton Brain",
    characteristics: "Logical, mathematical, foundational",
    description: "A brain known for its foundational work in classical mechanics.",
    specialities: "Mathematics, Physics",
    user: users.first,
    available: true,
    latitude: -33.9060,
    longitude: 18.4198,
    location: "Green Point, Cape Town"
  },
  {
    name: "Turing Brain",
    characteristics: "Analytical, pioneering, computational",
    description: "A brain celebrated for its contributions to computer science.",
    specialities: "Computer Science, Cryptography",
    user: users.second,
    available: false,
    latitude: -33.9708,
    longitude: 18.4246,
    location: "Newlands, Cape Town"
  },
  {
    name: "Lovelace Brain",
    characteristics: "Creative, mathematical, programming",
    description: "A brain known for its pioneering work in programming.",
    specialities: "Mathematics, Programming",
    user: users.third,
    available: true,
    latitude: -34.0109,
    longitude: 18.4051,
    location: "Hout Bay, Cape Town"
  },
  {
    name: "Mendel Brain",
    characteristics: "Experimental, analytical, genetic",
    description: "A brain renowned for its foundational work in genetics.",
    specialities: "Genetics, Botany",
    user: users.first,
    available: true,
    latitude: -33.9125,
    longitude: 18.3993,
    location: "Sea Point, Cape Town"
  }
])
 brains = Brain.all

brains.each_with_index do |brain, index|
  file = URI.open("https://picsum.photos/800/300/?random")
  brain.photo.attach(io: file, filename: "brain_#{index}.png", content_type: "image/png")
  brain.save!
end

puts "Brains created."

# Create bookings
puts "Creating bookings..."

bookings = Booking.create!([
  {
    brain: brains.first,
    user: users.second,
    length_of_time: 7,
    start_date: Date.today,
    status: "Confirmed"
  },
  {
    brain: brains.second,
    user: users.third,
    length_of_time: 14,
    start_date: Date.today + 1.week,
    status: "Pending"
  },
  {
    brain: brains.third,
    user: users.first,
    length_of_time: 3,
    start_date: Date.today + 2.weeks,
    status: "Confirmed"
  },
  {
    brain: brains.fourth,
    user: users.second,
    length_of_time: 5,
    start_date: Date.today + 3.days,
    status: "Pending"
  }
])

puts "Bookings created."

puts "Seed data loaded successfully."
