# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

puts "Seeding database..."

puts "Sedding Users..."

for i in 0..10 do
  User.create!(name: Faker::Name.name, email: Faker::Internet.unique.email)
end

puts "Seeding Users... Done!"

puts "Seeding Events..."
users = User.all
previous_date_time = Time.current
users.each do |user|
  user.events.create!(start_time: previous_date_time,
                      end_time: previous_date_time + 1.hour,
                      is_physical_location: false,
                      location: "https://#{Faker::Internet.domain_name}")
  previous_date_time = previous_date_time + 2.hours
end
puts "Seeding Events... Done!"

puts "Seeding database... Done!"
