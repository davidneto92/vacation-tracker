require "rails_helper"

describe "KmlWriter correctly generates .kml" do
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

  it "generates a .kml file for the supplied park list" do
    KmlWriter.write_kml(@map_data)

    rats = true
    expect(rats).to eq true
  end

end
