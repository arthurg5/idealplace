class EventPlace < ApplicationRecord
  belongs_to :place
  belongs_to :event
  has_many :votes
end
