require "rails_helper"

feature "users can edit visits within a vacation" do
  scenario "signed in user can edit a visit they created" do
    visit "/"
    click_link "Sign in with Google"
    park = FactoryGirl.create(:park, name: "Kenai Fjords")
    vacation = FactoryGirl.create(:vacation, user: User.last,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    visit = Visit.create(user: User.last, vacation: vacation, park: park,
      start_date: vacation.start_date + 1, end_date: vacation.end_date - 1)

    FactoryGirl.create(:park, name: "Badlands")
    visit "/vacations/#{vacation.id}"

    expect(page).to have_content("from May 2 - 8")

    click_link "Edit"

    select "Badlands National Park", from: "park-visit-list"
    select "2016", from: "visit[start_date(1i)]"
    select "May", from: "visit[start_date(2i)]"
    select "4", from: "visit[start_date(3i)]"
    select "2016", from: "visit[end_date(1i)]"
    select "May", from: "visit[end_date(2i)]"
    select "7", from: "visit[end_date(3i)]"

    click_button "Create Visit"

    expect(page).to have_content("Visit updated!")
    expect(page).to have_link("Badlands National Park")
    expect(page).to have_content("from May 4 - 7")
    expect(vacation.visits.first.park.name).to eq "Badlands"
  end

  scenario "visit edit fails if the dates conflict with its Vacation"

  scenario "users cannot edit another user's visits"

  scenario "users must be signed in to edit a visit"
end
