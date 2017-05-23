require "rails_helper"

feature "users create a vacation" do
  scenario "signed in users can create a vacation" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/new"

    fill_in "Vacation Name", with: "Recent Trip to Utah"
    fill_in "Location", with: "Salt Lake City and Moab"
    select "2017", from: "vacation[start_date(1i)]"
    select "April", from: "vacation[start_date(2i)]"
    select "6", from: "vacation[start_date(3i)]"
    select "2017", from: "vacation[end_date(1i)]"
    select "April", from: "vacation[end_date(2i)]"
    select "11", from: "vacation[end_date(3i)]"
    choose "Yes"

    click_button("Create Vacation")

    expect(page).to have_content("Vacation created!")
    expect(page).to have_content("Recent Trip to Utah")
    expect(page).to have_content("Location: Salt Lake City and Moab")
    expect(page).to have_content("Vacation dates: April 6 - 11, 2017")
    expect(page).to have_content("By: #{User.last.name}")
  end

  scenario "vacations will not be created if insufficient data is provided"
  scenario "non-signed in users cannot create a vacation"
end
