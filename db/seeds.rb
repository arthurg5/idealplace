require 'faker'

# Clear existing data
EventPlace.destroy_all
Place.destroy_all
Event.destroy_all
GroupUser.destroy_all
User.destroy_all
Group.destroy_all

puts 'Creating fake users'

lucile = User.create(first_name: "Lucile", last_name: "Smith", nickname: "Lucile", email: "lucile@idealplace.com", password: "123456", address: "15, rue Oberkampf 75010 Paris")
arthur = User.create(first_name: "Arthur", last_name: "Johnson", nickname:"Arthur", email: "arthur@idealplace.com", password: "123456", address:"16, rue Oberkampf 75010 Paris")
abdelsam = User.create(first_name: "Abdelsam", last_name: "Palmas", nickname:"Abdelsam", email: "abdelsam@idealplace.com", password: "123456", address: "18, avenue de Paris 93123 Montreuil")
laure = User.create(first_name: "Laure", last_name: "Vega", nickname:"Laure", email: "laure@idealplace.com", password: "123456", address: "17, rue Cart 94160 Saint-Mandé")
timothee = User.create(first_name: "Timothée", last_name:"Dupont", nickname:"Timothée", email: "timothee@idealplace.com", password: "123456", address: "15, Cours de Vincennes 94300 Vincennes")
lucas = User.create(first_name: "Lucas", last_name:"Durand", nickname:"Lucas", email: "lucas@idealplace.com", password: "123456", address: "18, avenue Parmentier 75003 Paris")
kim = User.create(first_name: "Kim", last_name: "Jérémy", nickname: "Kim", email: "kim@idealplace.com", password: "123456", address: "20, avenue des pastéques 94300 Vincennes")
edward = User.create(first_name: "Edward", last_name: "Niceguy", nickname:"Niceguy", email: "edward@idealplace.com", password: "123456", address: "21, rue des melons 94300 Vincennes")

group1 = Group.create(name: "groupe1", user: arthur)
GroupUser.create(user: arthur, group: group1)
GroupUser.create(user: laure, group: group1)

group2 = Group.create(name: "groupe2", user: lucile)
GroupUser.create(user: lucile, group: group2)
GroupUser.create(user: abdelsam, group: group2)

group3 = Group.create(name: "groupe3", user: timothee)
GroupUser.create(user: timothee, group: group3)
GroupUser.create(user: kim, group: group3)

group4 = Group.create(name: "groupe4", user: lucas)
GroupUser.create(user: lucas, group: group4)
GroupUser.create(user: edward, group: group4)

# Seed data for Places
places = []
9.times do
  place = Place.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    category: Faker::Lorem.word,
    second_category: Faker::Lorem.word,
    third_category: Faker::Lorem.word,
    opening_hours: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
    rating: Faker::Number.between(from: 1, to: 5)
  )

  # Geocode after creating to populate latitude and longitude
  place.geocode
  place.save

  places << place
end

# Seed data for Events
events = []
5.times do
  event = Event.create!(
    user: arthur,
    name: Faker::Lorem.word,
    date: Faker::Date.forward(days: 23),
    start_time: Faker::Time.forward(days: 23),
    status: Event::STATUS.sample
  )

  # Assign 3 random places to each event
  places_for_event = places.sample(3)
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



# Event.destroy_all
# # Place.destroy_all
# User.destroy_all

# lucile = User.new(first_name: "Lucile", last_name: "Smith", nickname: "Lucile", email: "lucile@idealplace.com", password: "123456", address: "15, rue Oberkampf 75010 Paris")
# arthur = User.new(first_name: "arthur", last_name: "Johnson", nickname:"Arthur", email: "arthur@idealplace.com", password: "123456", address:"16, rue Oberkampf 75010 Paris")
# abdelsam = User.new(first_name: "abdelsam", last_name: "Palmas", nickname:"Abdelsam", email: "abdelsam@idealplace.com", password: "123456", address: "18, avenue de Paris 93123 Montreuil")
# laure = User.new(first_name: "Laure", last_name: "Vega", nickname:"Laure", email: "laure@idealplace.com", password: "123456", address: "17, rue Cart 94160 Saint-Mandé")
# timothee = User.new(first_name: "Timothée", last_name:"Dupont", nickname:"Timothée", email: "timothee@idealplace.com", password: "123456", address: "15, Cours de Vincennes 94300 Vincennes")
# lucas = User.new(first_name: "Lucas", last_name:"Durand", nickname:"Lucas", email: "lucas@idealplace.com", password: "123456", address: "18, avenue Parmentier 75003 Paris")
# kim = User.new(first_name: "Kim", last_name: "Jérémy", nickname: "Kim", email: "kim@idealplace.com", password: "123456", address: "20, avenue des pastéques 94300 Vincennes")
# edward = User.new(first_name: "Edward", last_name:"Niceguy", nickname:"Niceguy", email: "edward@idealplace.com", password: "123456", address: "21, rue des melons 94300 Vincennes")

# lucile.save!
# arthur.save!
# abdelsam.save!
# laure.save!
# timothee.save!
# lucas.save!
# kim.save!
# edward.save!


# puts "#{User.all.count} users created"

# lucile.avatar.attach(
#   io: File.open('public/images/lucille.jpg'),
#   filename: 'lucille.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# lucile.save!

# arthur.photo.attach(
#   io: File.open('public/images/user-2.jpg'),
#   filename: 'arthur.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# arthur.save!

# abdelsam.photo.attach(
#   io: File.open('public/images/abdelsam.jpg'),
#   filename: 'abdelsam.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# abdelsam.save!

# laure.photo.attach(
#   io: File.open('public/images/user-1.jpg'),
#   filename: 'user-1.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# laure.save!

# timothee.photo.attach(
#   io: File.open('public/images/user-2.jpg'),
#   filename: 'user-2.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# timothee.save!

# lucas.photo.attach(
#   io: File.open('public/images/user-2.jpg'),
#   filename: 'user-2.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# lucas.save!

# kim.photo.attach(
#   io: File.open('public/images/user-1.jpg'),
#   filename: 'user-1.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# kim.save!

# edward.photo.attach(
#   io: File.open('public/images/edward.jpg'),
#   filename: 'edward.jpg', # use the extension of the attached file here
#   content_type: 'image/jpg' # ideally use the mime type of the attached file here, like 'image/jpg''
# )
# edward.save!



# party = Event.new(name: "Kim's bday!", date: Date.today, start_time: Date.today)
# tapas = Event.new(name: "Tapas juntos!", date: Date.today, start_time: Date.today)
# beer = Event.new(name: "Beer time!", date: Date.today, start_time: Date.today)
# bailar = Event.new(name: "Bailamos juntos!", date: Date.today, start_time: Date.today)
# codechallenge = Event.new(name: "Challengeons notre code!", date: Date.today, start_time: Date.today)
# wedding = Event.new(name: "My wedding party!", date: Date.today, start_time: Date.today)

# party.user = kim
# party.save!

# tapas.user = edward
# tapas.save!

# beer.user = lucas
# beer.save!

# bailar.user = laure
# bailar.save!

# codechallenge.user = lucile
# codechallenge.save!

# wedding.user = arthur
# wedding.save!

# puts "#{Event.all.count} events created"

# EventUser.create!(
#   user_address: "64 rue des Dames, 75017 Paris",
#   transport: "driving",
#   event: Event.find_by(name: "Anniv de Laura"),
#   user: laura
# )

# puts 'Creating fake users'

# lucile = User.create(first_name: "Lucile", last_name: "Smith", nickname: "Lucile", email: "lucile@idealplace.com", password: "123456", address: "15, rue Oberkampf 75010 Paris")
# arthur = User.create(first_name: "Arthur", last_name: "Johnson", nickname:"Arthur", email: "arthur@idealplace.com", password: "123456", address:"16, rue Oberkampf 75010 Paris")
# abdelsam = User.create(first_name: "Abdelsam", last_name: "Palmas", nickname:"Abdelsam", email: "abdelsam@idealplace.com", password: "123456", address: "18, avenue de Paris 93123 Montreuil")
# laure = User.create(first_name: "Laure", last_name: "Vega", nickname:"Laure", email: "laure@idealplace.com", password: "123456", address: "17, rue Cart 94160 Saint-Mandé")
# timothee = User.create(first_name: "Timothée", last_name:"Dupont", nickname:"Timothée", email: "timothee@idealplace.com", password: "123456", address: "15, Cours de Vincennes 94300 Vincennes")
# lucas = User.create(first_name: "Lucas", last_name:"Durand", nickname:"Lucas", email: "lucas@idealplace.com", password: "123456", address: "18, avenue Parmentier 75003 Paris")
# kim = User.create(first_name: "Kim", last_name: "Jérémy", nickname: "Kim", email: "kim@idealplace.com", password: "123456", address: "20, avenue des pastéques 94300 Vincennes")
# edward = User.create(first_name: "Edward", last_name: "Niceguy", nickname:"Niceguy", email: "edward@idealplace.com", password: "123456", address: "21, rue des melons 94300 Vincennes")

# group1 = Group.create(name: "groupe1", user_id: arthur.id)
# GroupUser.create(user_id: arthur.id, group_id: group1.id)
# GroupUser.create(user_id: laure.id, group_id: group1.id)

# puts 'Seed creation is over!'
