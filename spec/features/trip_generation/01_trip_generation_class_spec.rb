require "rails_helper"

describe "trip generator finds parks along a route" do
  before(:each) do
    @park_01 = FactoryGirl.create(:park, latitude: 40, longitude: -105)
    @park_02 = FactoryGirl.create(:park, latitude: 41, longitude: -104)
    @park_03 = FactoryGirl.create(:park, latitude: 41.1, longitude: -103)
    @park_04 = FactoryGirl.create(:park, latitude: 50, longitude: -110)
  end

  it "correctly builds TripGeneration object" do
    params = {destination: @park_01.id, start_point: "Denver, CO, United States", duration: "4"}
    new_trip = TripGeneration.new(params)

    expect(new_trip.destination).to eq @park_01
    expect(new_trip.start_point.class).to eq Hash
    expect(new_trip.start_point_lat).to be_within(0.1).of(39.739)
    expect(new_trip.start_point_lng).to be_within(0.1).of(-104.990)
  end

  it "#line_scan searches along a route to find all matching locations" do
    params = {destination: @park_03.id, start_point: "Denver, CO, United States", duration: "4"}
    new_trip = TripGeneration.new(params)

    found_parks = new_trip.line_scan(
      {"lat" => new_trip.destination_lat, "lng" => new_trip.destination_lng},
      {"lat" => new_trip.start_point_lat, "lng" => new_trip.start_point_lng}
    )

    expect(found_parks.include?(@park_01)).to eq true
    expect(found_parks.include?(@park_02)).to eq true
    expect(found_parks.include?(@park_04)).to eq false
  end
end
