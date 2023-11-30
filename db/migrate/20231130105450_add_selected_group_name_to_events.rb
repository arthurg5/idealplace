class AddSelectedGroupNameToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :selected_group_name, :string
  end
end
