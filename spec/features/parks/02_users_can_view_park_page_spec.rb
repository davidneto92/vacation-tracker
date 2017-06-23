require "rails_helper"

feature "users view a page for each park" do
  scenario "users can view an individual page for each park" do
    park_01 = FactoryGirl.create(:park)

    visit "/parks"

    click_link "#{park_01.name}"

    expect(page).to have_content(park_01.name)
    expect(page).to have_content(park_01.state)
    expect(page).to have_content("Designation: #{park_01.park_type}")
    expect(page).to have_content("Reachable by car: Yes")
    expect(page).to have_link("Directions to #{park_01.name}")
  end

  scenario "users can return to the park index from the show page" do
    park_01 = FactoryGirl.create(:park)
    visit "/parks/#{park_01.id}"

    click_link "Back to all parks"
    expect(page).to have_content("All National Parks")
  end

  scenario "correct lisiting if park cannot be driven to" do
    park_01 = FactoryGirl.create(:park, drivable: false)

    visit "/parks/#{park_01.id}"

    expect(page).to have_content(park_01.name)
    expect(page).to have_content(park_01.state)
    expect(page).to have_content("Designation: #{park_01.park_type}")
    expect(page).to have_content("Reachable by car: No")
    expect(page).to_not have_link("Directions to #{park_01.name}")
  end


  pending "show page lists nearby parks listed"

end
