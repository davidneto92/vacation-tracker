require "rails_helper"

feature "users view pages about the parks" do
  scenario "users can view an index of all parks" do
    park_01 = FactoryGirl.create(:park)
    park_02 = FactoryGirl.create(:park)
    visit "/parks"

    expect(page).to have_content("All National Parks")

    expect(page).to have_link(park_01.name)
    expect(page).to have_content(park_01.park_type)
    expect(page).to have_content(park_01.state)
    expect(page).to have_link(park_02.name)
    expect(page).to have_content(park_02.park_type)
    expect(page).to have_content(park_02.state)
  end

  pending "park index can be sorted?"
  pending "park index is paginated?"
end
