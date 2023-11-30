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
# ... (create other users)

puts 'Creating fake groups'

group1 = Group.create(name: "groupe1", user: arthur)
GroupUser.create(user: arthur, group: group1)
GroupUser.create(user: laure, group: group1)
# ... (create other groups)
group2 = Group.create(name: "groupe2", user: lucile)
GroupUser.create(user: lucile, group: group2)
GroupUser.create(user: abdelsam, group: group2)

group3 = Group.create(name: "groupe3", user: timothee)
GroupUser.create(user: timothee, group: group3)
GroupUser.create(user: kim, group: group3)

group4 = Group.create(name: "groupe4", user: lucas)
GroupUser.create(user: lucas, group: group4)
GroupUser.create(user: edward, group: group4)

puts 'Creating manual places'

paris_places = []

pizza_italia = Place.create!(name: "Pizza Italia", address: "12 rue de Charonne 75011 Paris", phone: "01 75 12 34 56", category: "restauration", second_category: "restaurant", third_category: "italien", opening_hours: "20h00", rating: 3)
# ... (create other manual places)
movie1 = Place.create!(name: "Batman", address: "2 cours Saint-Emilion 75012 Paris", phone: "01 75 33 74 66", category: "divertissement", second_category: "cinema", third_category: "Action", opening_hours: "14h00", rating: 4)
asiatique = Place.create!(name: "my nem is", address: "35 avenue de Choisy 75011 Paris", phone: "01 75 42 54 77", category: "restauration", second_category: "restaurant", third_category: "chinois", opening_hours: "19h00", rating: 3)
musee = Place.create!(name: "Le Louvre", address: "120 rue de Rivoli 75001 Paris", phone: "01 75 32 38 54", category: "culture", second_category: "monument", third_category: "musée", opening_hours: "10h00", rating: 5)
bar1 = Place.create!(name: "bar parallele", address: "18 boulevard Voltaire 75011 Paris", phone: "01 75 19 44 76", category: "restauration", second_category: "bar", third_category: "irish", opening_hours: "19h00", rating: 3)
movie2 = Place.create!(name: "Thor", address: "45 rue Ginou 75015 Paris", phone: "01 75 39 24 16", category: "divertissement", second_category: "cinema", third_category: "Action", opening_hours: "18h00", rating: 4)
turc = Place.create!(name: "Ca bosse fort", address: "66 boulevard Saint-Germain 75007 Paris", phone: "01 75 72 59 17", category: "restauration", second_category: "restaurant", third_category: "grec", opening_hours: "19h00", rating: 3)
musee = Place.create!(name: "Orsay", address: "Esplanade Valéry Giscard d'Estaing 75007 Paris", phone: "01 75 42 68 34", category: "culture", second_category: "monument", third_category: "musée", opening_hours: "10h00", rating: 5)
cafe = Place.create!(name: "couleur cafe", address: "28 Rue Charlot 75003 Paris", phone: "01 75 72 84 36", category: "restauration", second_category: "restaurant", third_category: "italien", opening_hours: "20h00", rating: 3)
movie3 = Place.create!(name: "Superman", address: "45 rue de belleville 75020 Paris", phone: "01 75 83 79 26", category: "divertissement", second_category: "cinema", third_category: "comedie", opening_hours: "14h00", rating: 3)


puts 'Creating fake events'

# Seed data for Events
events = []
5.times do
  event = Event.create!(
    user: arthur,
    name: Faker::Lorem.word,
    date: Faker::Date.forward(days: 23),
    start_time: Faker::Time.forward(days: 23),
    status: Event::STATUS.sample,
    selected_group_name: "No group"
  )

  # Assign 3 random places to each event
  places_for_event = [pizza_italia, movie1, asiatique, musee, bar1, movie2, turc, musee, cafe, movie3].sample(3)
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
