class User < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_users, dependent: :destroy

  validates :first_name, :last_name, :nickname, :email, :password, :address, presence: true
  # :latitude, :longitude
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
