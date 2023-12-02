require 'faker'
require "open-uri"

# Clear existing data
EventPlace.destroy_all
Place.destroy_all
Event.destroy_all
GroupUser.destroy_all
User.destroy_all
Group.destroy_all

puts 'Creating fake users'

users = []

users << User.new(first_name: "Lucile", last_name: "Smith", nickname: "Lucile", email: "lucile@idealplace.com", password: "123456", address: "15, rue Oberkampf 75010 Paris")
users << User.new(first_name: "Arthur", last_name: "Johnson", nickname:"Arthur", email: "arthur@idealplace.com", password: "123456", address:"16, rue Oberkampf 75010 Paris")
users << User.new(first_name: "Abdelsam", last_name: "Palmas", nickname:"Abdelsam", email: "abdelsam@idealplace.com", password: "123456", address: "18, avenue de Paris 93123 Montreuil")
users << User.new(first_name: "Laure", last_name: "Vega", nickname:"Laure", email: "laure@idealplace.com", password: "123456", address: "17, rue Cart 94160 Saint-Mandé")
users << User.new(first_name: "Timothée", last_name:"Dupont", nickname:"Timothée", email: "timothee@idealplace.com", password: "123456", address: "15, Cours de Vincennes 94300 Vincennes")
users << User.new(first_name: "Lucas", last_name:"Durand", nickname:"Lucas", email: "lucas@idealplace.com", password: "123456", address: "18, avenue Parmentier 75003 Paris")
users << User.new(first_name: "Kim", last_name: "Jérémy", nickname: "Kim", email: "kim@idealplace.com", password: "123456", address: "20, avenue des pastéques 94300 Vincennes")
users << User.new(first_name: "Edward", last_name: "Niceguy", nickname:"Niceguy", email: "edward@idealplace.com", password: "123456", address: "21, rue des melons 94300 Vincennes")
# ... (create other users)
# users = [lucile, arthur, abdelsam, laure, timothee, lucas, kim, edward]


# Attach images to user's avatars
puts "Creating photos for users"

users.each do |user|
  file = URI.open("https://source.unsplash.com/random/70x70/?face")
  user.photo.attach(io: file, filename: "#{user.nickname}_avatar.png", content_type: "image/png")
  user.save!
end

arthur = User.where(nickname: "Arthur").first
lucile = User.where(nickname: "Lucile").first
laure = User.where(nickname: "Laure").first
abdelsam = User.where(nickname: "Abdelsam").first
timothee = User.where(nickname: "Timothée").first
lucas = User.where(nickname: "Lucas").first
kim = User.where(nickname: "Kim").first
edward = User.where(nickname: "Edward").first

puts "#{users.count} users created"

puts 'Creating fake groups'

group1 = Group.create(name: "groupe1", user: arthur)
GroupUser.create(user: arthur, group: group1)
GroupUser.create(user: laure, group: group1)
# ... (create other groups)
group2 = Group.create(name: "groupe2", user: arthur)
GroupUser.create(user: lucile, group: group2)
GroupUser.create(user: abdelsam, group: group2)

group3 = Group.create(name: "groupe3", user: arthur)
GroupUser.create(user: timothee, group: group3)
GroupUser.create(user: kim, group: group3)

group4 = Group.create(name: "groupe4", user: arthur)
GroupUser.create(user: lucas, group: group4)
GroupUser.create(user: edward, group: group4)

puts 'Creating manual places'

paris_places = []

paris_places <<pizza_italia=  Place.new(name: "Pizza Italia", address: "12 rue de Charonne 75011 Paris", phone: "01 75 12 34 56", category: "Catering", second_category: "Restaurant", third_category: "Italian", opening_hours: "20h00", rating: 3)
# ... (new other manual places)
movie1 = Place.new(name: "Batman", address: "2 cours Saint-Emilion 75012 Paris", phone: "01 75 33 74 66", category: "Entertainment", second_category: "Cinema", third_category: "Action", opening_hours: "14h00", rating: 4)
paris_places << movie1

asiatique = Place.new(name: "my nem is", address: "35 avenue de Choisy 75011 Paris", phone: "01 75 42 54 77", category: "Catering", second_category: "Restaurant", third_category: "Chinese", opening_hours: "19h00", rating: 3)
paris_places << asiatique

musee1 = Place.new(name: "Le Louvre", address: "120 rue de Rivoli 75001 Paris", phone: "01 75 32 38 54", category: "Culture", second_category: "Monument", third_category: "Museum", opening_hours: "10h00", rating: 5)
paris_places << musee1

bar1 = Place.new(name: "bar parallele", address: "18 boulevard Voltaire 75011 Paris", phone: "01 75 19 44 76", category: "Catering", second_category: "Bar", third_category: "Irish", opening_hours: "19h00", rating: 3)
paris_places << bar1

movie2 = Place.new(name: "Thor", address: "45 rue Ginou 75015 Paris", phone: "01 75 39 24 16", category: "Entertainment", second_category: "Cinema", third_category: "Action", opening_hours: "18h00", rating: 4)
paris_places << movie2

turc = Place.new(name: "Ca bosse fort", address: "66 boulevard Saint-Germain 75007 Paris", phone: "01 75 72 59 17", category: "Catering", second_category: "Restaurant", third_category: "Greek", opening_hours: "19h00", rating: 3)
paris_places << turc

musee2 = Place.new(name: "Orsay", address: "Esplanade Valéry Giscard d'Estaing 75007 Paris", phone: "01 75 42 68 34", category: "Culture", second_category: "Monument", third_category: "Museum", opening_hours: "10h00", rating: 5)
paris_places << musee2

cafe = Place.new(name: "wouleur cafe", address: "28 Rue Charlot 75003 Paris", phone: "01 75 72 84 36", category: "Catering", second_category: "Restaurant", third_category: "Italian", opening_hours: "20h00", rating: 3)
paris_places << cafe

movie3 = Place.new(name: "Superman", address: "45 rue de belleville 75020 Paris", phone: "01 75 83 79 26", category: "Entertainment", second_category: "Cinema", third_category: "Comedy", opening_hours: "14h00", rating: 3)
paris_places << movie3

paris_places.each do |paris_place|
  paris_places_pic = URI.open("https://source.unsplash.com/random/250x250/?restaurant,paris")
  paris_place.photo.attach(io: paris_places_pic, filename: "#{paris_place.name}_image.png", content_type: "image/png")
  paris_place.save!
end

puts 'Creating fake events'

# Seed data for Events
events = []
7.times do
  event = Event.create!(
    user: users.sample,
    name: Faker::Lorem.word,
    date: Faker::Date.forward(days: 23),
    start_time: Faker::Time.forward(days: 23),
    status: Event::STATUS.sample,
    selected_group_name: "No group"
  )

  # Assign 3 random places to each event
  places_for_event = [pizza_italia, movie1, asiatique, musee1, bar1, movie2, turc, musee2, cafe, movie3].sample(3)
  places_for_event.each do |place|
    EventPlace.create!(
      duration: Faker::Number.number(digits: 2),
      distance: Faker::Number.decimal(l_digits: 2),
      transport_mode: Faker::Lorem.word,
      selected: [false].sample,
      place: place,
      event: event
    )
  end
  events << event
end


puts 'Seed creation is over!'
