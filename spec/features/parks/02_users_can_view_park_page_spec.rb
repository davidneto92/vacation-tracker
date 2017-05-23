require "rails_helper"

feature "users view a page for each park" do
  scenario "users can view an individual page for each park" do
    park_01 = FactoryGirl.create(:park)

    visit "/parks"

    click_link "#{park_01.name}"

    expect(page).to have_content(park_01.name)
    expect(page).to have_content(park_01.state)
    expect(page).to have_content("Type: #{park_01.park_type}")
  end

  pending "show page lists nearby parks listed"

end
