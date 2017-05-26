require "rails_helper"

feature "users can add visits to vacations" do
  scenario "users must be signed in to create a visit" do
    user = FactoryGirl.create(:user, name: "Milhouse Van Houten")
    vacation_01 = FactoryGirl.create(:vacation, user: user, display_public: true)

    visit "/vacations/#{vacation_01.id}"
    expect(page).to_not have_link("Add a Visit")

    visit "/vacations/#{vacation_01.id}/visits/new"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "users cannot add a visit to a vacation they do not own" do
    user = FactoryGirl.create(:user, name: "Bart Simpson")
    vacation_01 = FactoryGirl.create(:vacation, user: user, display_public: true)

    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/#{vacation_01.id}"
    expect(page).to_not have_link("Add a Visit")

    visit "/vacations/#{vacation_01.id}/visits/new"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
