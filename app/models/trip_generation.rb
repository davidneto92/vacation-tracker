# NOTE: Coordinates format: {"lat" => y, "lng" => x}
class TripGeneration
  attr_accessor :destination, :start_point, :duration, :found_parks

  def initialize(params)
    @destination = Park.find(params[:destination])
    @start_point = parse_start_data(params[:start_point])
    @duration = params[:duration].to_i
    @found_parks = []
  end

  def start_point_lat
    @start_point["geometry"]["location"]["lat"]
  end

  def start_point_lng
    @start_point["geometry"]["location"]["lng"]
  end

  def start_point_name
    @start_point["formatted_address"]
  end

  def destination_lat
    @destination.latitude
  end

  def destination_lng
    @destination.longitude
  end

  # This method walks through each step of a route to perform a line_scan
  def route_trace
    directions_data = JSON.parse(RestClient.get("https://maps.googleapis.com/maps/api/directions/json?units=imperial&origin=#{ URI.encode(start_point_name) }&destination=#{ URI.encode(@destination.full_name) }4&key=#{ ENV["GOOGLE_DIRECTIONS_KEY"] }"))
    route_steps = directions_data["routes"].first["legs"].first["steps"]

    route_steps.each do |step|
      line_scan(
        {"lat" => (step["start_location"]["lat"]), "lng" => (step["start_location"]["lng"])},
        {"lat" => (step["end_location"]["lat"]), "lng" => (step["end_location"]["lng"])}
      )
    end
    @found_parks.delete(@destination)
    return @found_parks
  end

  # This method initiates area_checks along a straight line from point to point.
  def line_scan(start_coords, end_coords)
    scan_coords = start_coords
    rise, run, hypotenuse, slope, y_intercept = trigonometry(start_coords, end_coords)

    (hypotenuse.ceil).times do
      scan_coords["lat"] = ( (scan_coords["lng"] * slope) + y_intercept )

      results = area_check(scan_coords)
      results = results.select { |park| !@found_parks.include?(park) }
      if !results.empty?
        results = proximity_sort(scan_coords, results)
      end
      @found_parks += results

      if slope >= 0
        scan_coords["lng"] += ( (run / hypotenuse.ceil) )
      else
        scan_coords["lng"] += ( (run / hypotenuse.ceil) )
      end
    end
    return @found_parks
  end

  # This method returns a list of parks that exist within boundary of the
  # passed in coordinates. Because the United States covers a wide area,
  # the range differs slightly to give more leeway to longitude, and more closely
  # resemble a square area. This translate to roughly 100-110 mile search radius.
  def area_check(coords)
    return Park.all.where(drivable: true).select { |park|
      ((coords["lat"] - 1.1)..(coords["lat"] + 1.1)).include?(park.latitude) && (coords["lng"] - 1.3..coords["lng"] + 1.3).include?(park.longitude)
    }
  end

  def proximity_sort(scan_coords, results)
    sorted_results = []
    results.each do |park|
      rise, run, hypotenuse, slope, y_intercept = trigonometry(scan_coords, {"lat" => park.latitude, "lng" => park.longitude})
      sorted_results << {"park" => park, "distance_to_scan" => hypotenuse}
    end

    sorted_results.sort_by! { |result| result["distance_to_scan"] }
    return sorted_results.map { |park| park["park"] }
  end

  def trigonometry(start_coords, end_coords)
    rise        = (end_coords["lat"] - start_coords["lat"])
    run         = (end_coords["lng"] - start_coords["lng"])
    hypotenuse  = (Math.sqrt( (rise ** 2) + (run ** 2) ))
    slope       = (rise / run)
    y_intercept = ( start_coords["lat"] - (start_coords["lng"] * slope) )
    return [rise, run, hypotenuse, slope, y_intercept]
  end

  private

  def parse_start_data(start_point)
    response = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ URI.encode(start_point) }&key=#{ ENV["GOOGLE_GEOCODING_KEY" ]}")
    geocode_response = JSON.parse(response)
    return geocode_response["results"].first
  end

end
