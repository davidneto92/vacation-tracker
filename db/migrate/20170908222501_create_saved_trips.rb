class CreateSavedTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :savedtrips do |t|
      t.jsonb :start_point, null: false
      t.string :destination_name, null: false
      t.integer :destination_park_id      
      t.integer :found_parks, array: true
      t.jsonb :directions_data, null: false
      
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
