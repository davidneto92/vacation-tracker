require "rails_helper"

feature "users cannot edit another user's visits within a vacation" do
  before(:each) do
    @user = FactoryGirl.create(:user, name: "Lisa Simpson")
    @park_01 = FactoryGirl.create(:park)
    @vacation = FactoryGirl.create(:vacation, user: @user,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: @user, vacation: @vacation, park: @park_01,
      start_date: @vacation.start_date + 1, end_date: @vacation.end_date - 1)
  end

  scenario "users cannot edit another user's visits" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/#{@vacation.id}"
    expect(page).to_not have_link "Edit Visit"

    visit "/vacations/#{@vacation.id}/visits/#{@visit.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "users must be signed in to edit a visit" do
    visit "/vacations/#{@vacation.id}"
    expect(page).to_not have_link "Edit Visit"

    visit "/vacations/#{@vacation.id}/visits/#{@visit.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "users cannot delete another user's visits" do
    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/#{@vacation.id}"
    expect(page).to_not have_link "Delete Visit"

    page.driver.submit :delete, "/vacations/#{@vacation.id}/visits/#{@visit.id}", {}
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
