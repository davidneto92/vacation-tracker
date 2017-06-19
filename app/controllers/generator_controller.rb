class GeneratorController < ApplicationController
  def index
    @park_list = Park.all.where(drivable: true).order(:name)
  end

  def show
    new_trip = TripGeneration.new(params)
    @destination = new_trip.destination
    @start_point_string = new_trip.start_point_name

    @found_parks = new_trip.line_scan(
      {"lat" => new_trip.start_point_lat, "lng" => new_trip.start_point_lng},
      {"lat" => new_trip.destination_lat, "lng" => new_trip.destination_lng}
    )

  end

end
