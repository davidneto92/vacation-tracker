class SavedTrip < ApplicationRecord
  belongs_to :user
  has_many :parks
  
  # if a user wishes to save a trip that they have generated to their account
  # they can press a button to create a record of this trip.
  # All CRUD functions performable on SavedTrip, displaying the trip will
  # look almost identical to the generator page.

  def destination_park
    Park.find(destination_park_id) if destination_park_id
  end

  def start_point_name
    destination_trip.start_point["address"]
  end
end
