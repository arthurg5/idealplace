class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.float :barycenter_lng
      t.float :barycenter_lat
      t.date :date
      t.time :start_time
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
