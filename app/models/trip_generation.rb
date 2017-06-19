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

  # def find_parks
  # end

  # this method walks through each step of a route to perform a line_scan
  # def route_trace
  # end

  # This method initiates area_checks along a straight line from point to point.
  def line_scan(start_coords, end_coords) # {"lat" => y, "lng" => x}
    rise, run, hypotenuse, slope, y_intercept = trigonometry(start_coords, end_coords)
    scan_coords = start_coords

    (hypotenuse.ceil).times do
      scan_coords["lat"] = ( (scan_coords["lng"] * slope) + y_intercept ).round(3)

      results = area_check(scan_coords)
      results = results.select { |park| !@found_parks.include?(park) }
      if !results.empty?
        results = proximity_sort(scan_coords, results)
      end
      @found_parks += results

      if slope >= 0
        scan_coords["lng"] += ( (run / hypotenuse.ceil).round(3) )
      else
        scan_coords["lng"] += ( (run / hypotenuse.ceil).round(3) )
      end
    end

    @found_parks.delete(@destination)
    return @found_parks#.uniq
  end

  # This method returns a list of parks that exist within the bounds
  # pass in coords hash {"lat" => y, "lng" => x}
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
    rise        = (end_coords["lat"] - start_coords["lat"]).round(3)
    run         = (end_coords["lng"] - start_coords["lng"]).round(3)
    hypotenuse  = (Math.sqrt( (rise ** 2) + (run ** 2) )).round(3)
    slope       = (rise / run).round(3)
    y_intercept = ( start_coords["lat"] - (start_coords["lng"] * slope) ).round(3)
    return [rise, run, hypotenuse, slope, y_intercept]
  end

  private

  def parse_start_data(start_point)
    response = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ URI.encode(start_point) }&key=#{ ENV["GOOGLE_GEOCODING_KEY" ]}")
    geocode_response = JSON.parse(response)
    return geocode_response["results"].first
  end

end
