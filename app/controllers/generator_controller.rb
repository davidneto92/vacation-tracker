class GeneratorController < ApplicationController
  def index
    @park_list = Park.all.where(drivable: true).order(:name)
  end

  def show
    new_trip = TripGeneration.new(params)
    @destination = new_trip.destination
    @start_point_string = new_trip.start_point_name

    @found_parks = new_trip.route_trace    
  end

end
