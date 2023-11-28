class Event < ApplicationRecord
  belongs_to :user
  has_many :event_users, dependent: :destroy
  has_many :event_places, dependent: :destroy

  STATUS = %w(Created Voted Passed)

  validates :name, :date, :start_time, presence: true
 #  validates :status, inclusion: { in: STATUS, message: "%{value} is not a valid status type" }
end

# :barycenter_lng, :barycenter_lat
