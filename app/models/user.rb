class User < ApplicationRecord
  has_many_attached :photos
  has_many :groups, dependent: :destroy
  has_many :group_users, through: :groups, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_users, dependent: :destroy
  has_many :event_places, through: :events, dependent: :destroy

  acts_as_favoritor

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  validates :first_name, :last_name, :nickname, :email, :password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
