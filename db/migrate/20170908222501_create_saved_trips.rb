class CreateSavedTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :savedtrips do |t|

      t.timestamps
    end
  end
end
