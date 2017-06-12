require "rails_helper"

describe "KmlWriter correctly generates .kml" do
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
    KmlWriter.write_kml(@map_data, @user.uid)

    file_fixture("Visited_Parks_#{Time.now.strftime("%d%m%Y")}_MyString.kml").read.include?("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
    file_fixture("Visited_Parks_#{Time.now.strftime("%d%m%Y")}_MyString.kml").read.include?("<name>National Park 01 National Park</name><description><![CDATA[Official NPS Site:<br>https://www.nps.gov/acad/index.htm<br>Last visited on May  8, 2016]]></description>")
    file_fixture("Visited_Parks_#{Time.now.strftime("%d%m%Y")}_MyString.kml").read.include?("<description><![CDATA[Official NPS Site:<br>https://www.nps.gov/acad/index.htm]]></description>")
  end

end
