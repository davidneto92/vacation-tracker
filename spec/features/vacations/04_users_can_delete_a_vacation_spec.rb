require "rails_helper"

feature "users can delete a vacation" do
  scenario "user can visit a page to delete their account information" do
    visit "/"
    click_link "Sign in with Google"
    vacation_01 = FactoryGirl.create(:vacation, user: User.last)

    visit "/vacations/#{vacation_01.id}/edit"

    click_button "Delete this Vacation"
    expect(User.last.vacations.empty?).to be true
  end

  scenario "users cannot delete another user's vacation" do
    user = FactoryGirl.create(:user, name: "Mayor Quimby")
    vacation_01 = FactoryGirl.create(:vacation, user: user)

    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/#{vacation_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")

    page.driver.submit :delete, "/vacations/#{vacation_01.id}", {}
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
