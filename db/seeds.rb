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

EventPlace.destroy_all
Place.destroy_all
Event.destroy_all

# Seed data for Places
3.times do
  Place.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    category: Faker::Lorem.word,
    second_category: Faker::Lorem.word,
    third_category: Faker::Lorem.word,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    distance: Faker::Number.decimal(l_digits: 2),
    opening_hours: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    rating: Faker::Number.between(from: 1, to: 5)
  )
end

# Seed data for Events
3.times do
  Event.create!(
    user_id: 3,
    name: Faker::Lorem.word,
    barycenter_lng: Faker::Address.longitude,
    barycenter_lat: Faker::Address.latitude,
    date: Faker::Date.forward(days: 23),
    start_time: Faker::Time.forward(days: 23),
    status: Event::STATUS.sample
  )
end

# Seed data for EventPlaces (linking Events and Places)
events = Event.all
places = Place.all

events.each do |event|
  event_place = EventPlace.create!(
    duration: Faker::Number.number(digits: 2),
    distance: Faker::Number.decimal(l_digits: 2),
    transport_mode: Faker::Lorem.word,
    selected: [true, false].sample,
    place: places.sample,
    event: event
  )
end
