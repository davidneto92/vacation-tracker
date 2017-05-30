require "rails_helper"

feature "users can edit visits within a vacation" do
  before(:each) do
    visit "/"
    click_link "Sign in with Google"
    @park_01 = FactoryGirl.create(:park)
    @park_02 = FactoryGirl.create(:park)
    @vacation = FactoryGirl.create(:vacation, user: User.last,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: User.last, vacation: @vacation, park: @park_01,
      start_date: @vacation.start_date + 1, end_date: @vacation.end_date - 1)
  end

  scenario "signed in user can edit a visit they created" do
    visit "/vacations/#{@vacation.id}"

    click_link "Edit Visit"

    select @park_02.full_name, from: "park-visit-list"
    select "2016", from: "visit[start_date(1i)]"
    select "May", from: "visit[start_date(2i)]"
    select "4", from: "visit[start_date(3i)]"
    select "2016", from: "visit[end_date(1i)]"
    select "May", from: "visit[end_date(2i)]"
    select "7", from: "visit[end_date(3i)]"

    click_button "Create Visit"

    expect(page).to have_content("Visit updated!")
    expect(page).to have_link("#{@park_02.full_name}")
    expect(page).to have_content("from May 4 - 7")
    expect(@vacation.visits.first.park.name).to eq(@park_02.name)
  end

  scenario "visit edit fails if the dates conflict with its Vacation" do
    visit "/vacations/#{@vacation.id}"

    click_link "Edit Visit"

    select "2016", from: "visit[start_date(1i)]"
    select "April", from: "visit[start_date(2i)]"
    select "28", from: "visit[start_date(3i)]"
    select "2016", from: "visit[end_date(1i)]"
    select "May", from: "visit[end_date(2i)]"
    select "12", from: "visit[end_date(3i)]"

    click_button "Create Visit"

    expect(page).to_not have_content("Visit updated!")
    expect(page).to have_content("Visit was not updated.")
    expect(page).to have_content("Start date cannot conflict with the vacation dates.")
    expect(page).to have_content("End date cannot conflict with the vacation dates.")
  end

end
