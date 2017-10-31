class SavedTripsController < ApplicationController
  before_action :authorize_sign_in  

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

  private

  def authorize_sign_in
    if current_user.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end