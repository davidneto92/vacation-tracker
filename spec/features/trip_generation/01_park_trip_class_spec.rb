require "rails_helper"

describe "trip generator finds parks along a route via park trip" do
  before(:each) do
    @park_01 = FactoryGirl.create(:park, name: "Zion", latitude: 37.298, longitude: -113.026)
    @park_02 = FactoryGirl.create(:park, name: "Bryce", latitude: 37.593, longitude: -112.187)
    @park_03 = FactoryGirl.create(:park, name: "Capitol Reef", latitude: 38.367, longitude: -111.262)
    @park_04 = FactoryGirl.create(:park, name: "Great Sand Dunes", latitude: 37.792, longitude: -105.594)
  end

  it "correctly builds ParkTrip object" do
    params = {destination: @park_01.id, start_point: "Las Vegas, NV, United States"}
    new_trip = ParkTrip.new(params)

    expect(new_trip.destination).to eq @park_01
    expect(new_trip.directions_data.class).to eq Hash
    expect(new_trip.start_point.class).to eq Hash
    expect(new_trip.start_point_coords["lat"]).to be_within(0.1).of(36.170)
    expect(new_trip.start_point_coords["lng"]).to be_within(0.1).of(-115.140)
  end

  it "#area_check correctly finds parks within bounds of a point" do
    params = {destination: @park_01.id, start_point: "Las Vegas, NV, United States"}
    new_trip = ParkTrip.new(params)

    scan = new_trip.area_check("lat" => 37.437, "lng" => -112.621)
    expect(scan.include?(@park_01)).to eq true
    expect(scan.include?(@park_02)).to eq true
    expect(scan.include?(@park_05)).to eq false
  end

  it "#line_scan searches along a route to find all matching locations" do
    params = {destination: @park_03.id, start_point: "Las Vegas, NV, United States"}
    new_trip = ParkTrip.new(params)

    found_parks = new_trip.line_scan(
      {"lat" => new_trip.destination.latitude, "lng" => new_trip.destination.longitude},
      {"lat" => new_trip.start_point_coords["lat"], "lng" => new_trip.start_point_coords["lng"]}
    )

    expect(new_trip.found_parks.include?(@park_01)).to eq true
    expect(new_trip.found_parks.include?(@park_02)).to eq true
    expect(new_trip.found_parks.include?(@park_04)).to eq false
  end

  it "#proximity_sort correctly sorts found parks by their distance to the scan point" do
    params = {destination: @park_01.id, start_point: "Denver, CO, United States"}
    new_trip = ParkTrip.new(params)

    sorted = new_trip.proximity_sort(
      {"lat" => new_trip.start_point_coords["lat"], "lng" => new_trip.start_point_coords["lng"]},
      [@park_03, @park_01, @park_02]
    )

    expect(sorted).to eq [@park_03, @park_02, @park_01]
  end
end
