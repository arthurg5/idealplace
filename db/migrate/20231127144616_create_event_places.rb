class CreateEventPlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :event_places do |t|
      t.float :duration
      t.float :distance
      t.string :transport_mode
      t.boolean :selected, default: false, null: false
      t.references :place, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
