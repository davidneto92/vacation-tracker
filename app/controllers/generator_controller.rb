class GeneratorController < ApplicationController
  def index
    @park_list = Park.all.where(drivable: true).order(:name)
    @park_list = @park_list.collect{ |park| ["#{park.full_name} - #{park.state_abbreviation}", park.id] }
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
        @destination_string = new_trip.destination.full_name
      else
        new_trip = DestinationTrip.new(params)
        @destination_string = new_trip.destination
      end

      @start_point_string = new_trip.start_point_name
      @found_parks = new_trip.route_trace

      binding.pry

      @directions_link = new_trip.generate_directions_link
      @alphabet_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      @start_point_json = new_trip.start_point.to_json
      @found_parks_json = (@found_parks << @destination).to_json
    end
  end

end
