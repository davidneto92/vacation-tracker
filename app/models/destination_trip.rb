require_relative "trip_generation"

class DestinationTrip < TripGeneration

  def initialize(params)
    @destination = params[:destination_point]
    @directions_data = parse_directions(params[:start_point])
    @start_point = {
      "address" => @directions_data["routes"].first["legs"].first["start_address"],
      "coords" => @directions_data["routes"].first["legs"].first["start_location"]
    }
    @found_parks = []
  end

  def destination_data
    {
      name: @destination,
      full_name: @destination,
      latitude: destination_coords["lat"],
      longitude: destination_coords["lng"]
    }
  end

  def generate_directions_link
    link = "https://www.google.com/maps/dir/"
    link += "#{URI.encode(self.start_point_name)}/"
    @found_parks.each do |park|
      link += "#{URI.encode(park.full_name)}/"
    end
    link += "#{URI.encode(@destination)}"
    return link
  end

  private

  def parse_directions(start_point)
    JSON.parse(RestClient.get("https://maps.googleapis.com/maps/api/directions/json?units=imperial&origin=#{ URI.encode(start_point) }&destination=#{ URI.encode(@destination) }4&key=#{ ENV["GOOGLE_DIRECTIONS_KEY"] }"))
  end

end
