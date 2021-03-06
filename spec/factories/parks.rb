FactoryGirl.define do
  factory :park do
    sequence(:name) { |n| "National Park 0#{n}" }
    park_type "National Park"
    state Park::STATES.sample
    latitude 43.855
    longitude -102.340
    nps_url "https://www.nps.gov/acad/index.htm"
  end
end
