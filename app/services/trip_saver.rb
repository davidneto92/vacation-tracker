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
      trip_name: generate_name(park_trip.start_point['address'], park_trip.destination.full_name),
      user_id: user.id
    )
  end
    
  def self.save_destination_trip(destination_trip, user)
    SavedTrip.create(
      start_point: destination_trip.start_point,
      destination_name: destination_trip.destination,
      found_parks: destination_trip.found_parks,
      directions_data: destination_trip.directions_data,
      trip_name: generate_name(destination_trip.start_point['address'], destination_trip.destination),
      user_id: user.id
    )
  end

  # start with park trip
  def self.parse_trip_data(params, user)
    trip_to_save = SavedTrip.new(
      start_point: JSON.parse(params['start_point']),
      destination_name: params['destination_name'],
      found_parks: params['found_parks_list'].split(' ').map{ |id| id.to_i },
      directions_data: JSON.parse(params['directions_data']),
      user_id: user.id
    )
    trip_to_save.trip_name = generate_name(trip_to_save.start_point['address'], trip_to_save.destination_name)

    if params['trip_type'] == 'park'
      trip_to_save.destination_park_id = params['destination_id'].to_i
    end

    trip_to_save.save
    trip_to_save
  end
end