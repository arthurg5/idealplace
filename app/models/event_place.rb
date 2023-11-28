class EventPlace < ApplicationRecord
  belongs_to :place
  belongs_to :event

  validates :duration, :distance, :transport_mode, presence: true
end
