require "rails_helper"

feature "users can edit and delete their account" do
  scenario "user can visit a page to delete their account information" do
    visit "/"
    click_link "Sign in with Google"
    temp_id = User.last.id
    visit "/users/#{User.last.id}"

    click_link "Account Management"
    expect(page).to have_content("Account Management")
    click_button "Delete Account"

    expect(User.where(id: temp_id).empty?).to be true
    expect(page).to have_content("Vacation Tracker")
  end

  scenario "users cannot edit another user's account" do
    another_user = FactoryGirl.create(:user, name: "Terry Bull")

    visit "/"
    click_link "Sign in with Google"
    visit "/users/#{another_user.id}"

    expect(page).to_not have_link "Account Management"

    visit "/users/#{another_user.id}/edit"
    expect(page).to_not have_button "Delete Account"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  pending "admin can delete any account"
end
