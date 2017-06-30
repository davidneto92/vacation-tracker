require "rails_helper"

feature "users can access the link to download a .kml file their visits" do
  scenario "users must be signed in to download a map" do
    @user = FactoryGirl.create(:user)

    visit "/users/#{@user.id}/user_visits_download"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "users cannot download a map of another user's visits" do
    @user = FactoryGirl.create(:user)
    @park_01 = FactoryGirl.create(:park, latitude: 40.447, longitude: -80.002)
    @vacation = FactoryGirl.create(:vacation, user: @user,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: @user, vacation: @vacation, park: @park_01,
      start_date: @vacation.start_date + 1, end_date: @vacation.end_date - 1)

    visit "/"
    click_link "Sign in with Google"

    visit "/users/#{@user.id}"
    expect(page).to_not have_link("Export this map to Google My Maps")

    visit "/users/#{@user.id}/user_visits_download"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
