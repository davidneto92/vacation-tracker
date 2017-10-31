class AddTripNameToSavedTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :saved_trips, :trip_name, :string, null: false
  end
end
