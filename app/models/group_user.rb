class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, uniqueness: { scope: :user_id } # Ensure uniqueness of users in a group

end
