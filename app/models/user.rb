class User < ApplicationRecord
  has_one_attached :photo
  has_many :groups, dependent: :destroy
  has_many :group_users, through: :groups, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_users, dependent: :destroy
  has_many :event_places, through: :events, dependent: :destroy

  acts_as_favoritor

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, :last_name, :nickname, presence: true
  # validates :photo, attached: true, content_type: ['image/png', 'image/jpg', 'image/gif']
  # validates :photo, size: { less_than: 5.megabytes, message: 'must be less than 5MB' }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def notif
  end
end
