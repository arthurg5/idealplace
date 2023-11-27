class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :category
      t.string :second_category
      t.string :third_category
      t.float :latitude
      t.float :longitude
      t.float :distance
      t.time :opening_hours
      t.float :rating

      t.timestamps
    end
  end
end
