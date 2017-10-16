require "rails_helper"

describe "ParkTrips and DestinationTrips can be saved" do
  let!(:park_01) { FactoryGirl.create(:park, name: "Zion", latitude: 37.298, longitude: -113.026) }
  let!(:park_02) { FactoryGirl.create(:park, name: "Bryce", latitude: 37.593, longitude: -112.187) }
  let!(:park_03) { FactoryGirl.create(:park, name: "Capitol Reef", latitude: 38.367, longitude: -111.262) }
  let!(:park_04) { FactoryGirl.create(:park, name: "Great Sand Dunes", latitude: 37.792, longitude: -105.594) }  
  let!(:new_user) { FactoryGirl.create(:user) }

  context "ParkTrip can be converted" do
    let!(:params) { { destination: park_03.id, start_point: "Las Vegas, NV, United States" } }
    let!(:park_trip) { ParkTrip.new(params) }

    it "converts to a SavedTrip" do
      saved_trip = TripSaver.save_park_trip(park_trip, new_user)
      
      expect(saved_trip.user).to eq new_user
      expect(saved_trip.start_point).to eq park_trip.start_point
      expect(saved_trip.destination_name).to eq park_03.name
      expect(saved_trip.destination_park).to eq park_03
      expect(saved_trip.directions_data).to eq park_trip.directions_data
    end
  end  

  context "DestinationTrip can be converted"  do
    let!(:params) { { destination_point: "Moab, UT, United States", start_point: "Las Vegas, NV, United States" } }
    let!(:destination_trip) { DestinationTrip.new(params) }

    it "converts to a SavedTrip" do
      saved_trip = TripSaver.save_destination_trip(destination_trip, new_user)

      expect(saved_trip.user).to eq new_user
      expect(saved_trip.start_point).to eq destination_trip.start_point
      expect(saved_trip.destination_name).to eq params[:destination_point]
      expect(saved_trip.directions_data).to eq destination_trip.directions_data
    end
  end

end