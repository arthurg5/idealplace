class EventPlace < ApplicationRecord
  belongs_to :place
  belongs_to :event
  has_many :votes, dependent: :destroy

  validates :duration, :distance, :transport_mode, presence: true
end
