require "rails_helper"

feature "users can view their vacations on their account page" do
  scenario "a user visits their own user page to see all their vacations" do
    visit "/"
    click_link "Sign in with Google"
    vacation_01 = FactoryGirl.create(:vacation, user: User.last, display_public: true)
    vacation_02 = FactoryGirl.create(:vacation, user: User.last, display_public: false)

    visit user_path(User.last)

    expect(page).to have_link("#{vacation_01.name}")
    expect(page).to have_link("#{vacation_02.name}")
  end

  scenario "a user visits another users page to see their public vacations" do
    user = FactoryGirl.create(:user, name: "Carl Carlson")
    vacation_01 = FactoryGirl.create(:vacation, user: user, display_public: true)
    vacation_02 = FactoryGirl.create(:vacation, user: user, display_public: false)

    visit "/"
    click_link "Sign in with Google"

    visit user_path(user)

    expect(page).to have_link("#{vacation_01.name}")
    expect(page).to_not have_link("#{vacation_02.name}")
  end

end
