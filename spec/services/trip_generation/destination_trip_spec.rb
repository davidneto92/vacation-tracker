require "rails_helper"

describe "trip generator finds parks along a route via destination trip" do
  let!(:park_01) { FactoryGirl.create(:park, name: "Zion", latitude: 37.298, longitude: -113.026) }
  let!(:park_02) { FactoryGirl.create(:park, name: "Bryce", latitude: 37.593, longitude: -112.187) }
  let!(:park_03) { FactoryGirl.create(:park, name: "Capitol Reef", latitude: 38.367, longitude: -111.262) }
  let!(:park_04) { FactoryGirl.create(:park, name: "Great Sand Dunes", latitude: 37.792, longitude: -105.594) }

  let!(:params) { { destination_point: "Moab, UT, United States", start_point: "Las Vegas, NV, United States" } }
  let!(:destination_trip) { DestinationTrip.new(params) }
  
  it "correctly builds DestinationTrip object" do
    expect(destination_trip.destination).to eq "Moab, UT, United States"
    expect(destination_trip.directions_data.class).to eq Hash
    expect(destination_trip.start_point.class).to eq Hash
    expect(destination_trip.start_point_coords["lat"]).to be_within(0.1).of(36.170)
    expect(destination_trip.start_point_coords["lng"]).to be_within(0.1).of(-115.140)
    expect(destination_trip.destination_data[:lat]).to be_within(0.1).of(38.57)
    expect(destination_trip.destination_data[:lng]).to be_within(0.1).of(-109.55)
  end

  pending "error handling for DestinationTrip"
end
