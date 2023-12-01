class EventPlace < ApplicationRecord
  belongs_to :place
  belongs_to :event
  acts_as_favoritable

  # validates :duration, :distance, :transport_mode, presence: true
end
