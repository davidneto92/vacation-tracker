class CreateParks < ActiveRecord::Migration[5.0]
  def change
    create_table :parks do |t|
      t.string :name
      t.string :park_type
      t.string :state

      t.timestamps
    end
  end
end
