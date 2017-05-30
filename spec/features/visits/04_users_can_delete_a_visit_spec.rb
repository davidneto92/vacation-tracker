require "rails_helper"

feature "users can delete visits within a vacation" do

  before(:each) do
    visit "/"
    click_link "Sign in with Google"
    @park_01 = FactoryGirl.create(:park)
    @vacation = FactoryGirl.create(:vacation, user: User.last,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: User.last, vacation: @vacation, park: @park_01,
      start_date: @vacation.start_date + 1, end_date: @vacation.end_date - 1)
  end

  scenario "users can delete a visit from their vacation" do
    visit "/vacations/#{@vacation.id}"

    click_link "Delete Visit"

    expect(page).to have_content "Visit to #{@park_01.full_name} deleted."
    expect(@vacation.visits.empty?).to eq true
  end

  scenario "deleting a vacation will also delete it's related visits" do
    visit "/vacations/#{@vacation.id}/edit"

    click_button "Delete this Vacation"

    expect(@vacation.visits.empty?).to eq true
    expect(Vacation.all.empty?).to eq true
    expect(Visit.all.empty?).to eq true
  end

end
