class SavedTripsController < ApplicationController
  def index
    @saved_trips = SavedTrip.all.where(user_id: current_user)
  end

  def show
  end

  def create
    binding.pry
    # need to get objects from generator controller to here
    # saved_trip = TripSaver.save_park_trip(park_trip, current_user)
    # redirect_to saved_trips(saved_trip)
  end

end