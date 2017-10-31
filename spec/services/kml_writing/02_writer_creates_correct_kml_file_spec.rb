require "rails_helper"

describe "KmlWriter generates full contents of .kml" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @park_01 = FactoryGirl.create(:park, latitude: 40.447, longitude: -80.002)
    @park_02 = FactoryGirl.create(:park, latitude: 36.173, longitude: -86.792)
    @vacation = FactoryGirl.create(:vacation, user: @user,
      start_date: Date.new(2016,5,1), end_date: Date.new(2016,5,9))
    @visit = Visit.create(user: @user, vacation: @vacation, park: @park_01,
      start_date: @vacation.start_date + 1, end_date: @vacation.end_date - 1)
    @map_data = UserVisitsSerializer.perform(@user)
  end

  it "generates a .kml file for the supplied park list" do
    path = KmlWriter.write_kml(@map_data, @user.uid)

    expect(path[0].include?("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")).to eq true
    expect(path[0].include?("<description><![CDATA[Official NPS Site:<br>https://www.nps.gov/acad/index.htm<br>Last visited on May  8, 2016]]></description>\n")).to eq true
    expect(path[0].include?("<description><![CDATA[Official NPS Site:<br>https://www.nps.gov/acad/index.htm]]></description>\n")).to eq true
  end

end
