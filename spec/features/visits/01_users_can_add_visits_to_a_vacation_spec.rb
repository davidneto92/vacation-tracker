require "rails_helper"

feature "users can add visits to vacations" do
  scenario "user can add a visit" do
    FactoryGirl.create(:park, name: "Acadia")
    FactoryGirl.create(:park, name: "Yellowstone")
    FactoryGirl.create(:park, name: "Olympic")

    visit "/"
    click_link "Sign in with Google"
    vacation_01 = FactoryGirl.create(:vacation, user: User.last, start_date: Date.new(2016,4,5), end_date: Date.new(2016,4,16))
    visit "/vacations/#{vacation_01.id}"

    click_link "Add a Visit"

    select "Olympic National Park", from: "park-visit-list"
    select "2016", from: "visit[start_date(1i)]"
    select "April", from: "visit[start_date(2i)]"
    select "7", from: "visit[start_date(3i)]"
    select "2016", from: "visit[end_date(1i)]"
    select "April", from: "visit[end_date(2i)]"
    select "12", from: "visit[end_date(3i)]"

    click_button "Create Visit"

    expect(page).to have_content("Visit added to #{vacation_01.name}.")
    expect(page).to have_link("Olympic National Park")
    expect(page).to have_content("April 7, 2016")
    expect(page).to have_content("April 12, 2016")
    expect(vacation_01.visits.first.park.name).to eq "Olympic"
  end

  scenario "visits not created if the dates conflict with the vacation" do
    FactoryGirl.create(:park, name: "Grand Tetons")

    visit "/"
    click_link "Sign in with Google"
    vacation_01 = FactoryGirl.create(:vacation, user: User.last, start_date: Date.new(2016,6,10), end_date: Date.new(2016,6,16))
    visit "/vacations/#{vacation_01.id}"

    click_link "Add a Visit"

    select "Grand Tetons National Park", from: "park-visit-list"
    select "2016", from: "visit[start_date(1i)]"
    select "June", from: "visit[start_date(2i)]"
    select "4", from: "visit[start_date(3i)]"
    select "2016", from: "visit[end_date(1i)]"
    select "June", from: "visit[end_date(2i)]"
    select "21", from: "visit[end_date(3i)]"

    click_button "Create Visit"

    expect(page).to have_content("Visit was not added.")
    expect(page).to have_content("Start date cannot conflict with the vacation dates.")
    expect(page).to have_content("End date cannot conflict with the vacation dates.")
    expect(page).to_not have_content("Visit added to #{vacation_01.name}.")
  end

end
