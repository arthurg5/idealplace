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
users << User.new(first_name: "Lucile", last_name: "Smith", nickname: "Lucile", email: "lucile@idealplace.com", password: "123456", address: "75 Av. des Champs-Élysées, 75008 Paris") # This is the address of Ladurée, a famous tea room[^1^][1]
users << User.new(first_name: "Arthur", last_name: "Johnson", nickname:"Arthur", email: "arthur@idealplace.com", password: "123456", address:"6 rue de Furstenberg, 75006 Paris") # This is the address of the Musée national Eugène Delacroix[^2^][2]
users << User.new(first_name: "Abdelsam", last_name: "Palmas", nickname:"Abdelsam", email: "abdelsam@idealplace.com", password: "123456", address: "2 rue de l'Abreuvoir, 75018 Paris") # This is the address of the Maison Rose, a charming pink house and restaurant[^3^][3]
users << User.new(first_name: "Laure", last_name: "Vega", nickname:"Laure", email: "laure@idealplace.com", password: "123456", address: "196 rue de Belleville 75020 Paris") # This is the address of the Café de Flore, a legendary literary café[^3^][3]
users << User.new(first_name: "Timothée", last_name:"Dupont", nickname:"Timothée", email: "timothee@idealplace.com", password: "123456", address: "8 rue de Montpensier, 75001 Paris") # This is the address of the gardens of the Palais-Royal, a beautiful and peaceful spot[^3^][3]
users << User.new(first_name: "Lucas", last_name:"Durand", nickname:"Lucas", email: "lucas@idealplace.com", password: "123456", address: "108 avenue de Flandre, 75019 Paris") # This is the address of the Élysée Palace, the official residence of the French president
users << User.new(first_name: "Kim", last_name: "Jérémy", nickname: "Kim", email: "kim@idealplace.com", password: "123456", address: "1 rue de la Légion d'Honneur, 75007 Paris") # This is the address of the Musée d'Orsay, a former railway station turned into an art museum
users << User.new(first_name: "Edward", last_name: "Niceguy", nickname:"Edward", email: "edward@idealplace.com", password: "123456", address: "58 boulevard de Picpus, 75012 Paris") # This is the address of the Basilica of the Sacré-Cœur, a famous landmark on the Montmartre hill
users << User.new(first_name: "Alix", last_name: "Martin", nickname: "Alix", email: "alix@idealplace.com", password: "123456", address: "33 rue Vivienne, 75002 Paris") # This is the address of the Louvre Museum, the world’s largest art museum
users << User.new(first_name: "Pierre", last_name: "Leroy", nickname: "Pierre", email: "pierre@idealplace.com", password: "123456", address: "35 rue du Chevaleret, 75013 Paris") # This is the address of the Bibliothèque nationale de France, the national library of France
users << User.new(first_name: "Romain", last_name: "Dubois", nickname: "Romain", email: "romain@idealplace.com", password: "123456", address: "12 rue de Rivoli, 75004 Paris") # This is the address of the Hôtel de Ville, the city hall of Paris
users << User.new(first_name: "Stella", last_name: "Moreau", nickname: "Stella", email: "stella@idealplace.com", password: "123456", address: "14 rue du Perche, 75003 Paris") # This is the address of the Luxembourg Gardens, a beautiful public park
users << User.new(first_name: "Louis", last_name: "Bernard", nickname: "Louis", email: "louis@idealplace.com", password: "123456", address: "52 rue Mouffetard, 75005 Paris") # This is the address of the Arc de Triomphe, a monumental arch honoring those who fought for France
users << User.new(first_name: "Rhita", last_name: "Garcia", nickname: "Rhita", email: "rhita@idealplace.com", password: "123456", address: "6, place du Trocadéro et du 11 Novembre, 75016 Paris") # This is the address of the Palais de Chaillot, a cultural complex with museums and a theater
users << User.new(first_name: "Noémie", last_name: "Lopez", nickname: "Noémie", email: "noemie@idealplace.com", password: "123456", address: "42 rue des Vinaigriers, 75010 Paris") # This is the address of the Ministry of Foreign Affairs, the government department responsible for France’s foreign relations
users << User.new(first_name: "Lara", last_name: "Meyer", nickname: "Lara", email: "lara@idealplace.com", password: "123456", address: "120 boulevard Voltaire, 75011 Paris") # This is the address of the Place de la Concorde, the largest public square in Paris
users << User.new(first_name: "Joana", last_name: "Silva", nickname: "Joana", email: "joana@idealplace.com", password: "123456", address: "1, avenue du Colonel Henri Rol-Tanguy, 75014 Paris") # This is the address of the Catacombs of Paris, an underground ossuary holding the remains of millions of people

# Attach images to user's avatars
puts "Creating photos for users"

users.each do |user|
  file = File.open(Rails.root.join('app', 'assets', 'images', "#{user.nickname}.jpg"))
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
alix = User.where(nickname: "Alix").first
pierre = User.where(nickname: "Pierre").first
romain = User.where(nickname: "Romain").first
stella = User.where(nickname: "Stella").first
louis = User.where(nickname: "Louis").first
rhita = User.where(nickname: "Rhita").first
noemie = User.where(nickname: "Noémie").first
lara = User.where(nickname: "Lara").first
joana = User.where(nickname: "Joana").first

puts "#{users.count} users created"
puts 'Creating fake groups'

current_user = lucile
group1 = Group.create(name: "Best Friends", user: current_user)
GroupUser.create(user: alix, group: group1)
GroupUser.create(user: edward, group: group1)
GroupUser.create(user: current_user, group: group1)
GroupUser.create(user: arthur, group: group1)
GroupUser.create(user: timothee, group: group1)

group2 = Group.create(name: "Family", user: current_user)
GroupUser.create(user: lara, group: group2)
GroupUser.create(user: kim, group: group2)
GroupUser.create(user: rhita, group: group2)
GroupUser.create(user: current_user, group: group2)
GroupUser.create(user: joana, group: group2)
GroupUser.create(user: louis, group: group2)

group3 = Group.create(name: "Team Wagon", user: current_user)
GroupUser.create(user: lucas, group: group3)
GroupUser.create(user: abdelsam, group: group3)
GroupUser.create(user: laure, group: group3)
GroupUser.create(user: pierre, group: group3)
GroupUser.create(user: current_user, group: group3)
GroupUser.create(user: romain, group: group3)
GroupUser.create(user: stella, group: group3)
GroupUser.create(user: noemie, group: group3)

groups = [group1, group2, group3]

puts 'Creating manual places'

paris_places = []

# Catering
creperie = Place.create!(name: "La Crêperie Bretonne", address: "56 rue du Montparnasse 75014 Paris", phone: "01 75 43 21 65", category: "Catering", second_category: "Restaurant", third_category: "French", opening_hours: "12h00", rating: 4)
sushi = Place.create!(name: "Sushi Shop", address: "15 rue de la Pompe 75016 Paris", phone: "01 75 46 78 90", category: "Catering", second_category: "Restaurant", third_category: "Japanese", opening_hours: "18h00", rating: 4)
# Culture
opera = Place.create!(name: "Opéra Garnier", address: "8 rue Scribe 75009 Paris", phone: "01 75 47 81 23", category: "Culture", second_category: "Monument", third_category: "Opera", opening_hours: "10h00", rating: 5)
cathedral = Place.create!(name: "Notre-Dame de Paris", address: "6 parvis Notre-Dame 75004 Paris", phone: "01 75 48 82 34", category: "Culture", second_category: "Monument", third_category: "Cathedral", opening_hours: "08h00", rating: 5)
museum = Place.create!(name: "Musée d'Orsay", address: "1 rue de la Légion d'Honneur 75007 Paris", phone: "01 75 49 83 45", category: "Culture", second_category: "Museum", third_category: "Art", opening_hours: "09h30", rating: 5)
# Entertainment
zoo = Place.create!(name: "Parc Zoologique de Paris", address: "Avenue Daumesnil 75012 Paris", phone: "01 75 52 76 78", category: "Entertainment", second_category: "Zoo", third_category: "Animals", opening_hours: "09h30", rating: 4)
aquarium = Place.create!(name: "Aquarium Tropical de la Porte Dorée", address: "5 Avenue Albert de Mun 75116 Paris", phone: "07 71 92 14 14", category: "Entertainment", second_category: "Aquarium", third_category: "Fish", opening_hours: "12h00", rating: 3)
menagerie = Place.create!(name: "Ménagerie, le zoo du Jardin des Plantes", address: "57 Rue Cuvier 75005 Paris", phone: "01 40 79 56 01", category: "Entertainment", second_category: "Zoo", third_category: "Animals", opening_hours: "09h00", rating: 4)
cineaqua = Place.create!(name: "Aquarium de Paris - CineAqua", address: "5 Avenue Albert de Mun 75116 Paris", phone: "01 40 69 23 23", category: "Entertainment", second_category: "Aquarium", third_category: "Fish", opening_hours: "10h00", rating: 3.5)
galerie = Place.create!(name: "GALERIES, JARDINS, ZOO", address: "36 Rue Geoffroy-Saint-Hilaire 75005 Paris", phone: "01 40 79 56 01", category: "Entertainment", second_category: "Zoo", third_category: "Animals", opening_hours: "10h00", rating: 4.5)
acclimatation = Place.create!(name: "Jardin d'Acclimatation", address: "Bois de Boulogne 75116 Paris", phone: "01 40 67 90 85", category: "Entertainment", second_category: "Zoo", third_category: "Animals", opening_hours: "10h00", rating: 4)
# Catering
burger = Place.create!(name: "Big Fernand", address: "55 rue du Faubourg Poissonnière 75009 Paris", phone: "01 75 53 64 91", category: "Catering", second_category: "Restaurant", third_category: "American", opening_hours: "11h30", rating: 4)
salad = Place.create!(name: "Cojean", address: "8 rue de Sèze 75009 Paris", phone: "01 75 54 75 92", category: "Catering", second_category: "Restaurant", third_category: "Healthy", opening_hours: "09h00", rating: 4)
kebab = Place.create!(name: "Urfa Dürüm", address: "58 rue du Faubourg Saint-Denis 75010 Paris", phone: "01 75 55 86 93", category: "Catering", second_category: "Fast Food", third_category: "Turkish", opening_hours: "12h00", rating: 4)
# Culture
castle1 = Place.create!(name: "Château de Vincennes", address: "1 Avenue de Paris, 94300 Vincennes", phone: "01 48 08 31 20", category: "Culture", second_category: "Monument", third_category: "Castle", opening_hours: "10h00", rating: 4) # This is a medieval fortress that was once the residence of the French kings[^1^][1]
castle2 = Place.create!(name: "Château de Bagatelle", address: "42 Route de Sèvres à Neuilly, 75016 Paris", phone: "01 53 01 92 40", category: "Culture", second_category: "Monument", third_category: "Castle", opening_hours: "09h30", rating: 4.5) # This is a small neoclassical chateau that was built in 64 days as a result of a bet between Queen Marie-Antoinette and her brother-in-law[^2^][2]
castle3 = Place.create!(name: "Château de la Reine Blanche", address: "55 Rue du Moulin de la Pointe, 75013 Paris", phone: "01 45 80 66 00", category: "Culture", second_category: "Monument", third_category: "Castle", opening_hours: "08h30", rating: 3.5) # This is a mysterious Gothic-style building that is said to be haunted by the ghost of Queen Blanche of Castile, the mother of King Saint Louis[^3^][3]
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
  creperie, sushi, burger, salad, kebab,
  # Culture
  opera, cathedral, museum, castle1, castle2, castle3, church, gallery,
  # Entertainment
  zoo, concert, bowling, escape, aquarium, menagerie, cineaqua, galerie, acclimatation,
  # Previously listed places
  pizza_italia, movie_theater, boulangerie, pub, movie_cinema, french_restaurant, history_museum, theatre, street_food
]

paris_places.each do |paris_place|
  paris_places_pic = URI.open("https://source.unsplash.com/random/250x250/?restaurant,paris")
  paris_place.photo.attach(io: paris_places_pic, filename: "#{paris_place.name}_image.png", content_type: "image/png")
  paris_place.save!
end

puts 'Creating fake events'

# Seed data for Events
# Define events and event names
# Define events and event names
events_name1 = ["Birthday Party", "Back Home", "Start of Holidays!", "New Year’s Eve"]
events_name2 = ["Halloween Night", "Book Club Meeting", "Family Reunion", "Summer Camp"]

# Create events with random event_places and unique selected_group_names
events = events_name1.map do |event_name|
  selected_group_name = "Family"
  group_id = Group.find_by(name: selected_group_name).id

  # Ensure that the selected_group_name is unique
  event = Event.create!(
    user: lucile,
    name: event_name,
    date: Faker::Date.between(from: '2022-01-01', to: '2023-12-31'),
    start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
    status: "Passed",
    selected_group_name: selected_group_name,
    group_id: group_id
  )

  # Get three random places for each event
  places_for_event = paris_places.sample(3)

  # Create EventPlaces for each event
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
  event
end

events = events_name2.map do |event_name|
  selected_group_name = "Team Wagon"
  group_id = Group.find_by(name: selected_group_name).id

  # Ensure that the selected_group_name is unique
  event = Event.create!(
    user: lucile,
    name: event_name,
    date: Faker::Date.between(from: '2022-01-01', to: '2023-12-31'),
    start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
    status: "Passed",
    selected_group_name: selected_group_name,
    group_id: group_id
  )

  # Get three random places for each event
  places_for_event = paris_places.sample(3)

  # Create EventPlaces for each event
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
  event
end

puts 'Seed creation is over!'
