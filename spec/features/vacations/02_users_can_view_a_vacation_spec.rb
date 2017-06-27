require "rails_helper"

feature "users can view vacations" do
  scenario "index lists all vacations marked as public" do
    user = FactoryGirl.create(:user, name: "Carl Carlson")
    vacation_01 = FactoryGirl.create(:vacation, user: user)
    vacation_02 = FactoryGirl.create(:vacation, user: user)
    vacation_03 = FactoryGirl.create(:vacation, user: user, display_public: false)

    visit "/vacations"

    expect(page).to have_link("#{vacation_01.name}")
    expect(page).to have_link("#{vacation_02.name}")
    expect(page).to_not have_link("#{vacation_03.name}")
  end

  scenario "show page exists for each vacation" do
    user = FactoryGirl.create(:user, name: "Barney Gumble")
    vacation_01 = FactoryGirl.create(:vacation, user: user)

    visit "/vacations"
    click_link "#{vacation_01.name}"

    expect(page).to have_content("#{vacation_01.name}")
    expect(page).to have_content("Location: #{vacation_01.location}")
    expect(page).to have_content("By: #{user.name}")
  end

  scenario "users cannot view a vacation page that is not marked public" do
    user = FactoryGirl.create(:user, name: "Lenny Leonard")
    vacation_01 = FactoryGirl.create(:vacation, user: user, display_public: false)

    visit "/vacations/#{vacation_01.id}"
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit "/"
    click_link "Sign in with Google"
    visit "/vacations/#{vacation_01.id}"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "show page links to vacation creator's user page if user is signed in" do
    user = FactoryGirl.create(:user, name: "Moe Syzlak")
    vacation_01 = FactoryGirl.create(:vacation, user: user)

    visit "/vacations/#{vacation_01.id}"
    expect(page).to have_content("By: #{vacation_01.user.name}")
    expect(page).to_not have_link("#{vacation_01.user.name}")

    visit "/"
    click_link "Sign in with Google"
    visit "/vacations/#{vacation_01.id}"
    expect(page).to have_link("#{vacation_01.user.name}")
  end

end
