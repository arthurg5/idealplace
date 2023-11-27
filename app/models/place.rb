class Place < ApplicationRecord
  has_many :event_places, dependent: :destroy

  validates :name, :address, :phone, presence: true
  validates :category, :second_category, :third_category
  validates :latitude, :longitude, :distance, :opening_hours
  validates :rating, presence: true
end
