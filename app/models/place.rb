class Place < ApplicationRecord
  has_many :event_places, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :address, :phone, :category, :opening_hours, presence: true
  validates :second_category, :third_category, presence: true # Assuming these also should be present
  validates :rating, presence: true, inclusion: { in: 1..5 } # Assuming rating should be between 1 and 5
end
