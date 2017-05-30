require "rails_helper"

feature "users can sign in with their Google account" do
  scenario "user can sign into the site with a Google account" do
    visit "/"

    click_link "Sign in with Google"

    expect(page).to have_content("Signed in as Test Name")
    expect(page).to have_link("Sign out")
    expect(page).to have_content("Vacation Tracker")
  end

  scenario "user can sign out of the site" do
    visit "/"

    click_link "Sign in with Google"

    click_link "Sign out"

    expect(page).to_not have_content("Signed in as Test Name")
    expect(page).to have_link("Sign in with Google")
  end

  # scenario "user redirected to home page if there is an error logging in"

end
