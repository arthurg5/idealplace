class AddGroupIdToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :group, null: true, foreign_key: true
  end
end
