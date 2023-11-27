class User < ApplicationRecord
  has_many :groups
  has_many :votes
  has_many :group_users
  has_many :events
  has_many :event_users


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
