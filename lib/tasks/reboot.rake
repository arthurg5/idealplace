namespace :reboot do
  task event: :environment do
    event = Event.find(ENV.fetch("id"))
    event.event_places.destroy_all
  end
end
