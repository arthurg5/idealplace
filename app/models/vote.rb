class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :event_place
end
