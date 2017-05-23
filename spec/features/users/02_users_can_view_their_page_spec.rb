require "rails_helper"

feature "users view pages relating to their account" do
  scenario "a signed in user can view their account page" do
    visit "/"
    click_link "Sign in with Google"

    # not the best way to directly access the signed-in user's page
    visit "/users/#{User.last.id}"
    expect(page).to have_content("Profile for Test Name")
  end

  scenario "signed-in users can view another user's page" do
    user = FactoryGirl.create(:user, name: "Terry Bull")

    visit "/"
    click_link "Sign in with Google"

    visit "/users/#{user.id}"
    expect(page).to have_content("Profile for Terry Bull")
  end

  scenario "non-signed in users cannot view user pages" do
    user = FactoryGirl.create(:user, name: "Homer Simpson")

    visit "/users/#{user.id}"

    expect(page).to_not have_content("Profile for Homer Simpson")
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
