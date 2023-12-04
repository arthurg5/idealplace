require 'faker'
require "open-uri"
require 'httparty'

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

group1 = Group.create(name: "Work Friends", user: arthur)
GroupUser.create(user: arthur, group: group1)
GroupUser.create(user: laure, group: group1)

# ... (create other groups)
group2 = Group.create(name: "High School Friends", user: arthur)
GroupUser.create(user: lucile, group: group2)
GroupUser.create(user: abdelsam, group: group2)
GroupUser.create(user: arthur, group: group2)

group3 = Group.create(name: "Family", user: laure)
GroupUser.create(user: timothee, group: group3)
GroupUser.create(user: kim, group: group3)
GroupUser.create(user: laure, group: group3)

group4 = Group.create(name: "New Friends", user: laure)
GroupUser.create(user: lucas, group: group4)
GroupUser.create(user: edward, group: group4)
GroupUser.create(user: laure, group: group4)
GroupUser.create(user: kim, group: group4)

puts 'Creating manual places'

paris_places = []

# Catering
creperie = Place.create!(name: "La Crêperie Bretonne", address: "56 rue du Montparnasse 75014 Paris", phone: "01 75 43 21 65", category: "Catering", second_category: "Restaurant", third_category: "French", opening_hours: "12h00", rating: 4)
boulangerie = Place.create!(name: "Le Pain Quotidien", address: "18 place du Marché Saint-Honoré 75001 Paris", phone: "01 75 45 67 89", category: "Catering", second_category: "Bakery", third_category: "French", opening_hours: "08h00", rating: 3)
sushi = Place.create!(name: "Sushi Shop", address: "15 rue de la Pompe 75016 Paris", phone: "01 75 46 78 90", category: "Catering", second_category: "Restaurant", third_category: "Japanese", opening_hours: "18h00", rating: 4)

# Culture
opera = Place.create!(name: "Opéra Garnier", address: "8 rue Scribe 75009 Paris", phone: "01 75 47 81 23", category: "Culture", second_category: "Monument", third_category: "Opera", opening_hours: "10h00", rating: 5)
cathedral = Place.create!(name: "Notre-Dame de Paris", address: "6 parvis Notre-Dame - Place Jean-Paul II 75004 Paris", phone: "01 75 48 82 34", category: "Culture", second_category: "Monument", third_category: "Cathedral", opening_hours: "08h00", rating: 5)
museum = Place.create!(name: "Musée d'Orsay", address: "1 rue de la Légion d'Honneur 75007 Paris", phone: "01 75 49 83 45", category: "Culture", second_category: "Museum", third_category: "Art", opening_hours: "09h30", rating: 5)

# Entertainment
theatre = Place.create!(name: "Théâtre du Châtelet", address: "1 place du Châtelet 75001 Paris", phone: "01 75 50 84 56", category: "Entertainment", second_category: "Theatre", third_category: "Comedy", opening_hours: "20h00", rating: 4)
park = Place.create!(name: "Parc Astérix", address: "60128 Plailly", phone: "01 75 51 95 67", category: "Entertainment", second_category: "Theme Park", third_category: "Adventure", opening_hours: "10h00", rating: 4)
zoo = Place.create!(name: "Parc Zoologique de Paris", address: "Avenue Daumesnil 75012 Paris", phone: "01 75 52 76 78", category: "Entertainment", second_category: "Zoo", third_category: "Animals", opening_hours: "09h30", rating: 4)

# Catering
burger = Place.create!(name: "Big Fernand", address: "55 rue du Faubourg Poissonnière 75009 Paris", phone: "01 75 53 64 91", category: "Catering", second_category: "Restaurant", third_category: "American", opening_hours: "11h30", rating: 4)
salad = Place.create!(name: "Cojean", address: "8 rue de Sèze 75009 Paris", phone: "01 75 54 75 92", category: "Catering", second_category: "Restaurant", third_category: "Healthy", opening_hours: "09h00", rating: 4)
kebab = Place.create!(name: "Urfa Dürüm", address: "58 rue du Faubourg Saint-Denis 75010 Paris", phone: "01 75 55 86 93", category: "Catering", second_category: "Fast Food", third_category: "Turkish", opening_hours: "12h00", rating: 4)

# Culture
castle = Place.create!(name: "Château de Fontainebleau", address: "77300 Fontainebleau", phone: "01 75 56 97 94", category: "Culture", second_category: "Monument", third_category: "Castle", opening_hours: "09h30", rating: 5)
church = Place.create!(name: "Basilique du Sacré-Cœur", address: "35 rue du Chevalier-de-la-Barre 75018 Paris", phone: "01 75 57 98 95", category: "Culture", second_category: "Monument", third_category: "Church", opening_hours: "06h00", rating: 5)
gallery = Place.create!(name: "Centre Pompidou", address: "Place Georges-Pompidou 75004 Paris", phone: "01 75 58 99 96", category: "Culture", second_category: "Museum", third_category: "Modern Art", opening_hours: "11h00", rating: 5)

# Entertainment
concert = Place.create!(name: "L'Olympia", address: "28 boulevard des Capucines 75009 Paris", phone: "01 75 59 00 97", category: "Entertainment", second_category: "Concert Hall", third_category: "Music", opening_hours: "19h00", rating: 4)
bowling = Place.create!(name: "Bowling de Paris", address: "2 rue du Faubourg Montmartre 75009 Paris", phone: "01 75 60 01 98", category: "Entertainment", second_category: "Bowling Alley", third_category: "Sport", opening_hours: "14h00", rating: 4)
escape = Place.create!(name: "The Game", address: "51 rue du Cardinal Lemoine 75005 Paris", phone: "01 75 61 02 99", category: "Entertainment", second_category: "Escape Game", third_category: "Adventure", opening_hours: "10h00", rating: 4)


pizza_italia = Place.create!(
  name: "Pizza Italia",
  address: "12 rue de Charonne, 75011 Paris",
  phone: "01 75 12 34 56",
  category: "Catering",
  second_category: "Restaurant",
  third_category: "Italian",
  opening_hours: "20h00",
  rating: 3
)

movie_theater = Place.create!(
  name: "Luxor Movie Theater",
  address: "18 rue du Louvre, 75001 Paris",
  phone: "01 44 55 12 34",
  category: "Entertainment",
  second_category: "Movie Theater",
  third_category: "General",
  opening_hours: "14h00",
  rating: 4
)

boulangerie = Place.create!(
  name: "La Petite Boulangerie",
  address: "45 avenue Victor Hugo, 75016 Paris",
  phone: "01 55 43 21 87",
  category: "Catering",
  second_category: "Bakery",
  third_category: "French",
  opening_hours: "07h00",
  rating: 4
)

pub = Place.create!(
  name: "Le Petit Pub",
  address: "30 rue de Buci, 75006 Paris",
  phone: "01 42 22 98 76",
  category: "Catering",
  second_category: "Bar",
  third_category: "Pub",
  opening_hours: "18h00",
  rating: 4
)

movie_cinema = Place.create!(
  name: "Cinéma Pathé Beaugrenelle",
  address: "7 rue Linois, 75015 Paris",
  phone: "01 40 32 18 32",
  category: "Entertainment",
  second_category: "Cinema",
  third_category: "General",
  opening_hours: "12h30",
  rating: 4
)

french_restaurant = Place.create!(
  name: "Le Bon Goût",
  address: "18 avenue de la République, 75011 Paris",
  phone: "01 43 67 89 01",
  category: "Catering",
  second_category: "Restaurant",
  third_category: "French",
  opening_hours: "19h30",
  rating: 5
)

history_museum = Place.create!(
  name: "Musée de l'Histoire de France",
  address: "2 rue du Faubourg Saint-Honoré, 75008 Paris",
  phone: "01 58 01 12 33",
  category: "Culture",
  second_category: "History Museum",
  third_category: "French History",
  opening_hours: "10h00",
  rating: 4
)

theatre = Place.create!(
  name: "Théâtre de la Ville",
  address: "2 place du Châtelet, 75004 Paris",
  phone: "01 42 74 22 77",
  category: "Entertainment",
  second_category: "Theatre",
  third_category: "General",
  opening_hours: "18h30",
  rating: 5
)

street_food = Place.create!(
  name: "Le Camion Gourmand",
  address: "30 quai de la Tournelle, 75005 Paris",
  phone: "01 43 21 32 45",
  category: "Catering",
  second_category: "Street Food",
  third_category: "General",
  opening_hours: "11h00",
  rating: 4
)

paris_places = [
  # Catering
  creperie, boulangerie, sushi, burger, salad, kebab,

  # Culture
  opera, cathedral, museum, castle, church, gallery,

  # Entertainment
  theatre, park, zoo, concert, bowling, escape,

  # Previously listed places
  pizza_italia, movie_theater, boulangerie, pub, movie_cinema, french_restaurant, history_museum, theatre, street_food
]

paris_places.each do |paris_place|
  paris_places_pic = URI.open("https://source.unsplash.com/random/250x250/?restaurant,paris")
  paris_place.photo.attach(io: paris_places_pic, filename: "#{paris_place.name}_image.png", content_type: "image/png")
  paris_place.save!
end

puts 'Creating fake events'

events_name = ["Birthday Party", "Back Home", "Start of Holidays!", "New Year’s Eve", "Halloween Night", "Book Club Meeting", "Family Reunion", "Summer Camp"]

# Seed data for Events
events = []
7.times do
  event = Event.create!(
    user: users.sample,
    name: events_name.sample,
    date: Faker::Date.forward(days: 23),
    start_time: Faker::Time.forward(days: 23),
    status: Event::STATUS.sample,
    selected_group_name: group1.name,
    group_id: group1.id
  )

  # Assign 3 random places to each event
  places_for_event = paris_places.sample(3)
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
