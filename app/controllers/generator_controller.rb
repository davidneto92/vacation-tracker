class GeneratorController < ApplicationController
  def index
    @park_list = Park.all.where(drivable: true).order(:name)
  end

  def show
    @start_point_string = params[:start_point]
    response = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{ URI.encode(params[:start_point]) }&key=#{ ENV["GOOGLE_GEOCODING_KEY" ]}")
    geocode_response = JSON.parse(response)
    geocode_results = geocode_response["results"].first

    @start_coords = geocode_results["geometry"]["location"]
    @destination = Park.find(params[:destination])

    @found_parks = line_scan(@start_coords, {"lat" => @destination.latitude, "lng" => @destination.longitude})
    @found_parks.delete(@destination)
  end

  # This method initiates area scans along a straight line from point to point.
  # It will calculate the points along the line between the points and send each
  # point off to area_check.
  def line_scan(start_coords, end_coords) # LAT = Y  LNG = X
    found_parks = []
    rise        = (end_coords["lat"] - start_coords["lat"]).round(3)
    run         = (end_coords["lng"] - start_coords["lng"]).round(3)
    slope       = (rise / run).round(3)
    y_intercept = ( start_coords["lat"] - (start_coords["lng"] * slope) ).round(3)
    # hypotenuse  = (Math.sqrt( (rise ** 2) + (run ** 2) )).round(3)

    scan_coords = start_coords

    5.times do
      scan_coords["lat"] = ( (scan_coords["lng"] * slope) + y_intercept ).round(3)
      results = area_check(scan_coords)
      results.each do |park|
        found_parks << park
      end

      if slope >= 0
        scan_coords["lng"] += ( (run / 5.0).round(3) )
      else
        scan_coords["lng"] += ( (run / 5.0).round(3) )
      end
    end

    return found_parks.uniq
  end

  # This method returns a list of parks that exist within the bounds
  def area_check(coords)
    found = []
    Park.all.where(drivable: true).each do |park|
      if ((coords["lat"] - 1.1)..(coords["lat"] + 1.1)).include?(park.latitude) && (coords["lng"] - 1.3..coords["lng"] + 1.3).include?(park.longitude)
        found << park
      end
    end
    return found
  end

  def find_scan_quantity(hypotenuse_length)
  end

end
