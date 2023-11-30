class AddDefaultStatusToEvents < ActiveRecord::Migration[7.1]
  def change
    change_column_default :events, :status, "Created"
  end
end
