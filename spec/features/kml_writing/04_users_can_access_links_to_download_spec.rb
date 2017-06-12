require "rails_helper"

feature "users can access the link to download a .kml file their visits" do
  scenario "users can access the link to download a map of their locations" do
    visit "/"
    click_link "Sign in with Google"
    @park_01 = FactoryGirl.create(:park)
    @park_02 = FactoryGirl.create(:park)
    @vacation = FactoryGirl.create(:vacation, user: User.last,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: User.last, vacation: @vacation, park: @park_01,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,4))
    @visit = Visit.create(user: User.last, vacation: @vacation, park: @park_02,
      start_date: Date.new(2016,5,5), end_date: Date.new(2016,5,9))

    visit "/users/#{User.last.id}"

    click_button "Export to Google My Maps"

    expect( DownloadHelpers::download_content ).to include kml_export
  end

  pending "users must be signed in to download a map"
    # visit "/users/#{User.last.id}/user_visits_download"
    # expect(page).to_not have_content("The page you were looking for doesn't exist.")

  pending "users cannot download a map of another user's visits"
    # expect(page).to_not have_button("Export to Google My Maps")

    # visit "/users/#{User.last.id}/user_visits_download"
    # expect(page).to_not have_content("The page you were looking for doesn't exist.")

end
