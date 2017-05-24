require "rails_helper"

feature "users can view vacations" do
  scenario "users must be signed in to edit a vacation" do
    user = FactoryGirl.create(:user, name: "Carl Carlson")
    vacation_01 = FactoryGirl.create(:vacation, user: user)

    visit "/"

    visit "/vacations/#{vacation_01.id}"
    expect(page).to_not have_link("Edit this Vacation")

    visit "/vacations/#{vacation_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "users can edit the details of a vacation they created" do
    visit "/"
    click_link "Sign in with Google"
    vacation_01 = FactoryGirl.create(:vacation, user: User.last)
    visit "/vacations/#{vacation_01.id}"

    click_link "Edit this Vacation"

    expect(find_field("Location").value).to eq "#{vacation_01.location}"
    expect(find_field("Vacation Name").value).to eq "#{vacation_01.name}"

    fill_in "Vacation Name", with: "An even better name!"
    select "22", from: "vacation[start_date(3i)]"
    select "28", from: "vacation[end_date(3i)]"

    click_button "Create Vacation"

    expect(page).to have_content("Vacation has been updated.")
    expect(page).to have_content("An even better name!")
    expect(page).to have_content("Vacation dates: April 22 - 28, 2016")
  end

  scenario "users cannot edit another user's vacation" do
    user = FactoryGirl.create(:user, name: "Lenny Leonard")
    vacation_01 = FactoryGirl.create(:vacation, user: user)

    visit "/"
    click_link "Sign in with Google"

    visit "/vacations/#{vacation_01.id}"
    expect(page).to_not have_link("Edit this Vacation")

    visit "/vacations/#{vacation_01.id}/edit"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
