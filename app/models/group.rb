class Group < ApplicationRecord
  has_many :group_users
  belongs_to :user

end
