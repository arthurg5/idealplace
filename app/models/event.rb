class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group

  #has_many :users, through: :group_users
  has_many :event_users, dependent: :destroy
  has_many :event_places, dependent: :destroy
  has_many :places, through: :event_places

  after_initialize :set_default_status, if: :new_record?


  STATUS = %w(Created Voted Passed)

  validates :selected_group_name, :date, :start_time, presence: true

  def voted_by_user(user)
    !Favorite.where(favoritable_id: event_places.pluck(:id), favoritor_id: user.id).empty?
  end

  private

  def set_default_status
    self.status ||= 'Created'
  end
 #  validates :status, inclusion: { in: STATUS, message: "%{value} is not a valid status type" }
end

# :barycenter_lng, :barycenter_lat
