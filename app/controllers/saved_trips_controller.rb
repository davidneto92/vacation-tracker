class SavedTripsController < ApplicationController
  def index
    @saved_trips = SavedTrip.all.where(user_id: current_user)
  end

  def show
    @saved_trip = SavedTrip.find(params[:id])
  end

  def create
    saved_trip = TripSaver.parse_trip_data(params, current_user)
    redirect_to saved_trip_path(saved_trip)
  end

end