class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users # Association to access users through group_users
  has_many :events, dependent: :destroy

  belongs_to :user

  validates :name, presence: true
end
