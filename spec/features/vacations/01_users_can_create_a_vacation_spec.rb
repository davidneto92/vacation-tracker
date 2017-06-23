require "rails_helper"

feature "users create a vacation" do
  scenario "signed in users can create a vacation" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/new"

    fill_in "Vacation Name", with: "Recent Trip to Utah"
    fill_in "vacation[location]", with: "Salt Lake City and Moab"
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

  scenario "users can optionally provide a description of their vacation" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/new"

    fill_in "Vacation Name", with: "Fun times in Florida"
    fill_in "vacation[location]", with: "Everglades and Miami"
    fill_in "Description", with: "My friends and I made it to the Everglades and then Biscayne on the final day. Lot of fun!"
    select "2015", from: "vacation[start_date(1i)]"
    select "June", from: "vacation[start_date(2i)]"
    select "2", from: "vacation[start_date(3i)]"
    select "2015", from: "vacation[end_date(1i)]"
    select "June", from: "vacation[end_date(2i)]"
    select "5", from: "vacation[end_date(3i)]"
    choose "Yes"

    click_button("Create Vacation")

    expect(page).to have_content("Vacation created!")
    expect(page).to have_content("Fun times in Florida")
    expect(page).to have_content("By: #{User.last.name}")
    expect(page).to have_content("Location: Everglades and Miami")
    expect(page).to have_content("Vacation dates: June 2 - 5, 2015")
    expect(page).to have_content("Description: My friends and I made it to the Everglades and then Biscayne on the final day. Lot of fun!")
  end

  scenario "vacations will not be created if insufficient data is provided" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/new"

    click_button("Create Vacation")

    expect(page).to_not have_content("Vacation created!")
    expect(page).to have_content("errors in Vacation creation")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Name is too short (minimum is 5 characters)")
    expect(page).to have_content("Location can't be blank")
    expect(page).to have_content("Display public - please select if this vacation should be publicly viewable")
  end

  scenario "vacations must be created with valid dates" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/new"

    fill_in "Vacation Name", with: "Recent Trip to Utah"
    fill_in "vacation[location]", with: "Salt Lake City and Moab"
    select "2016", from: "vacation[start_date(1i)]"
    select "August", from: "vacation[start_date(2i)]"
    select "15", from: "vacation[start_date(3i)]"
    select "2016", from: "vacation[end_date(1i)]"
    select "August", from: "vacation[end_date(2i)]"
    select "11", from: "vacation[end_date(3i)]"
    choose "Yes"

    click_button("Create Vacation")

    expect(page).to_not have_content("Vacation created!")
    expect(page).to have_content("End date must be after the start date.")
  end

  scenario "non-signed in users cannot create a vacation" do
    visit "/vacations"
    expect(page).to_not have_link("Create a new vacation")

    visit "/vacations/new"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
