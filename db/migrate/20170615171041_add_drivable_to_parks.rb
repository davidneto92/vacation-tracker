class AddDrivableToParks < ActiveRecord::Migration[5.1]
  def change
    add_column :parks, :drivable, :boolean, default: true
  end
end
