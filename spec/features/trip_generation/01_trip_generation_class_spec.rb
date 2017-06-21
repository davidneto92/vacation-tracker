require "rails_helper"

describe "trip generator finds parks along a route" do
  before(:each) do
    @park_01 = FactoryGirl.create(:park, name: "Park 01", latitude: 40, longitude: -105)
    @park_02 = FactoryGirl.create(:park, name: "Park 02", latitude: 41, longitude: -104)
    @park_03 = FactoryGirl.create(:park, name: "Park 03", latitude: 41.1, longitude: -104.1)
    @park_04 = FactoryGirl.create(:park, name: "Park 04", latitude: 50, longitude: -110)
    @park_05 = FactoryGirl.create(:park, name: "Park 05", latitude: 45, longitude: -108)
  end

  it "correctly builds TripGeneration object" do
    params = {destination: @park_01.id, start_point: "Denver, CO, United States", duration: "4"}
    new_trip = TripGeneration.new(params)

    expect(new_trip.destination).to eq @park_01
    expect(new_trip.start_point.class).to eq Hash
    expect(new_trip.start_point_coords["lat"]).to be_within(0.1).of(39.739)
    expect(new_trip.start_point_coords["lng"]).to be_within(0.1).of(-104.990)
  end

  it "#area_check correctly finds parks within bounds of a point" do
    params = {destination: @park_01.id, start_point: "Denver, CO, United States", duration: "4"}
    new_trip = TripGeneration.new(params)

    scan = new_trip.area_check("lat" => 40.5, "lng" => -104.5)
    expect(scan.include?(@park_01)).to eq true
    expect(scan.include?(@park_02)).to eq true
    expect(scan.include?(@park_05)).to eq false
  end

  it "#line_scan searches along a route to find all matching locations" do
    params = {destination: @park_03.id, start_point: "Denver, CO, United States", duration: "4"}
    new_trip = TripGeneration.new(params)

    found_parks = new_trip.line_scan(
      {"lat" => new_trip.destination.latitude, "lng" => new_trip.destination.longitude},
      {"lat" => new_trip.start_point_coords["lat"], "lng" => new_trip.start_point_coords["lng"]}
    )

    expect(new_trip.found_parks.include?(@park_01)).to eq true
    expect(new_trip.found_parks.include?(@park_02)).to eq true
    expect(new_trip.found_parks.include?(@park_04)).to eq false
  end

  it "#proximity_sort correctly sorts found parks by their distance to the scan point" do
    params = {destination: @park_03.id, start_point: "Denver, CO, United States", duration: "4"}
    new_trip = TripGeneration.new(params)

    sorted = new_trip.proximity_sort(
      {"lat" => new_trip.destination.latitude, "lng" => new_trip.destination.longitude},
      [@park_01, @park_02, @park_03, @park_04, @park_05]
    )

    expect(sorted).to eq [@park_03, @park_02, @park_01, @park_05, @park_04]
  end
end
