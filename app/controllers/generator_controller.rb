class GeneratorController < ApplicationController
  def index
    @park_list = Park.all.where(drivable: true).order(:name)
  end

  def show
    if params[:start_point].empty?
      flash[:alert] = "Please specify a Starting Point."
      redirect_to generator_path
    else
      new_trip = TripGeneration.new(params)
      @destination = new_trip.destination
      @start_point_string = new_trip.start_point_name
      @found_parks = new_trip.route_trace
      @directions_link = new_trip.directions_link

      @alphabet_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

      @start_point_json = new_trip.start_point.to_json
      @found_parks_json = (@found_parks << @destination).to_json
    end
  end

end
