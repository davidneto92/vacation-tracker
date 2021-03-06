class TripGeneration
  attr_accessor :destination, :start_point, :found_parks, :directions_data

  def start_point_coords
    @start_point["coords"]
  end

  def start_point_name
    @start_point["address"]
  end

  def destination_coords
    @directions_data["routes"][0]["legs"][0]["end_location"]
  end

  # This method walks through each step of a route to perform a line_scan
  def route_trace
    route_steps = @directions_data["routes"].first["legs"].first["steps"]

    route_steps.each do |step|
      line_scan(
        {"lat" => (step["start_location"]["lat"]), "lng" => (step["start_location"]["lng"])},
        {"lat" => (step["end_location"]["lat"]), "lng" => (step["end_location"]["lng"])}
      )
    end
    @found_parks.delete(@destination) if @destination.class == Park
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
  end

  # roughly 100-110 mile search area
  def area_check(coords)
    return Park.all.where(drivable: true).select { |park|
      ((coords["lat"] - 1.1)..(coords["lat"] + 1.1)).include?(park.latitude) && (coords["lng"] - 1.2..coords["lng"] + 1.2).include?(park.longitude)
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

end
