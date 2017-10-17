class GeneratorController < ApplicationController
  def index
    @park_list = Park.drivable_park_list
    @park_list.insert(0,["Select a park...", 0])
  end

  def show
    if params[:start_point].empty?
      flash[:alert] = "Please specify a Starting Point."
      redirect_to generator_path
    elsif params[:destination_point].empty? && params[:destination] == "0"
      flash[:alert] = "Please specify a Destination or Park."
      redirect_to generator_path
    else

      if params[:destination_point].empty?
        new_trip = ParkTrip.new(params)
        @found_parks = new_trip.route_trace
        @destination_string = new_trip.destination.full_name
        @found_parks_json = build_found_parks_json(@found_parks << new_trip.destination, new_trip)
        @render_park_table = true
      else
        new_trip = DestinationTrip.new(params)
        @found_parks = new_trip.route_trace
        @destination_string = new_trip.destination
        @found_parks_json = build_found_parks_json(@found_parks, new_trip)
        @destination_data = new_trip.destination_data
      end

      @start_point_json = new_trip.start_point.to_json
      @start_point_string = new_trip.start_point_name
      @directions_link = new_trip.generate_directions_link
      @alphabet_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"      
    end

    @test_data = {'a': 1, 'b': 2}.to_json
  end

  private

  def build_found_parks_json(found_parks, new_trip)
    new_list = []
    found_parks.each do |park|
      park_hash = park.serializable_hash
      park_hash["full_name"] = park.full_name
      new_list << park_hash
    end

    new_list << new_trip.destination_data if new_trip.class == DestinationTrip

    return new_list.to_json
  end

end
