class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
