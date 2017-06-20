require "rails_helper"

describe "trip generator page displays correct results" do
  before(:each) do
    @park_01 = FactoryGirl.create(:park, name: "Big Bend", latitude: 29.128, longitude: -103.243)
    @park_02 = FactoryGirl.create(:park, name: "Carlsbad Caverns", latitude: 32.148, longitude: -104.557)
    @park_03 = FactoryGirl.create(:park, name: "Guadalupe Mountains", latitude: 31.945, longitude: -104.873)
    @park_04 = FactoryGirl.create(:park, name: "Arches", latitude: 38.733, longitude: -109.593)
  end

  scenario "generator will not proceed if the starting point is empty" do
    visit "/generator"
    select "#{@park_01.full_name} - #{@park_01.state_abbreviation}", from: "destination"
    click_button "Generate"

    expect(page).to have_content("Please specify a Starting Point.")
    expect(page).to_not have_content("the following locations may be on your way")
  end

  scenario "generator correctly lists locations along a supplied route" do
    visit "/generator"

    fill_in "Starting Point", with: "El Paso, TX"
    select "#{@park_01.full_name} - #{@park_01.state_abbreviation}", from: "destination"
    click_button "Generate"

    expect(page).to_not have_content("Please specify a Starting Point.")
    expect(page).to have_content("On your trip from El Paso, TX, USA to Big Bend National Park")
    expect(page).to have_content("Guadalupe Mountains National Park Carlsbad Caverns National Park")
  end

end
