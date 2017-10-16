require "rails_helper"

describe "trip generator finds parks along a route via park trip" do
  let!(:park_01) { FactoryGirl.create(:park, name: "Zion", latitude: 37.298, longitude: -113.026) }
  let!(:park_02) { FactoryGirl.create(:park, name: "Bryce", latitude: 37.593, longitude: -112.187) }
  let!(:park_03) { FactoryGirl.create(:park, name: "Capitol Reef", latitude: 38.367, longitude: -111.262) }
  let!(:park_04) { FactoryGirl.create(:park, name: "Great Sand Dunes", latitude: 37.792, longitude: -105.594) }

  let!(:params) { { destination: park_03.id, start_point: "Las Vegas, NV, United States" } }
  let!(:park_trip) { ParkTrip.new(params) }
  
  it "correctly builds ParkTrip object" do
    expect(park_trip.destination).to eq park_03
    expect(park_trip.directions_data.class).to eq Hash
    expect(park_trip.start_point.class).to eq Hash
    expect(park_trip.start_point_coords["lat"]).to be_within(0.1).of(36.170)
    expect(park_trip.start_point_coords["lng"]).to be_within(0.1).of(-115.140)
  end

  it "#area_check correctly finds parks within bounds of a point" do
    scan = park_trip.area_check("lat" => 37.437, "lng" => -112.621) # between Zion and Bryce
    expect(scan.include?(park_01)).to eq true
    expect(scan.include?(park_02)).to eq true
    expect(scan.include?(park_04)).to eq false
  end

  it "#line_scan searches along a route to find all matching locations" do
    found_parks = park_trip.line_scan(
      {"lat" => park_trip.destination.latitude, "lng" => park_trip.destination.longitude},
      {"lat" => park_trip.start_point_coords["lat"], "lng" => park_trip.start_point_coords["lng"]}
    )

    expect(park_trip.found_parks.include?(park_01)).to eq true
    expect(park_trip.found_parks.include?(park_02)).to eq true
    expect(park_trip.found_parks.include?(park_04)).to eq false
  end

  it "#proximity_sort correctly sorts found parks by their distance to the scan point" do
    sorted = park_trip.proximity_sort(
      {"lat" => park_trip.start_point_coords["lat"], "lng" => park_trip.start_point_coords["lng"]},
      [park_03, park_01, park_02]
    )

    expect(sorted).to eq [park_01, park_02, park_03]
  end

  pending "error handling for ParkTrip"
end
