class TripSaver
  def self.generate_name(start, destination)
    "Trip from #{start} to #{destination}"
  end
  
  def self.save_park_trip(park_trip, user)
    SavedTrip.create(
      start_point: park_trip.start_point,
      destination_name: park_trip.destination.name,
      destination_park_id: park_trip.destination.id,
      found_parks: park_trip.found_parks,
      directions_data: park_trip.directions_data,
      trip_name: generate_name(park_trip.start_point["address"], park_trip.destination.full_name),
      user_id: user.id
    )
  end
    
  def self.save_destination_trip(destination_trip, user)
    SavedTrip.create(
      start_point: destination_trip.start_point,
      destination_name: destination_trip.destination,
      found_parks: destination_trip.found_parks,
      directions_data: destination_trip.directions_data,
      trip_name: generate_name(destination_trip.start_point["address"], destination_trip.destination),
      user_id: user.id
    )
  end
end