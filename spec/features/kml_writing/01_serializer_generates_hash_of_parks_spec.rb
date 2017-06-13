require "rails_helper"

describe "UserVisitsSerializer generates hash of all parks" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @park_01 = FactoryGirl.create(:park)
    @park_02 = FactoryGirl.create(:park)
    @vacation = FactoryGirl.create(:vacation, user: @user,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: @user, vacation: @vacation, park: @park_01,
      start_date: @vacation.start_date + 1, end_date: @vacation.end_date - 1)
    @map_data = UserVisitsSerializer.perform(@user)
  end

  it "generates a correct entry for a park a user has visited" do
    expect(@map_data[0]["name"]).to eq @park_01.name
    expect(@map_data[0]["visited"]).to eq true
    expect(@map_data[0]["most_recent_visit_date"]).to eq @visit.end_date.strftime "%B %e, %Y"
  end

  it "generates a correct entry for a park a users has not visited" do
    expect(@map_data[1]["name"]).to eq @park_02.name
    expect(@map_data[1]["visited"]).to eq false
    expect(@map_data[1]["most_recent_visit_date"]).to eq nil
  end

end
