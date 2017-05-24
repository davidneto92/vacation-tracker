FactoryGirl.define do
  factory :vacation do
    sequence(:name) { |n| "Vacation 0#{n}" }
    location Park::STATES.sample
    display_public true
    start_date Date.new(2016,4,19)
    end_date Date.new(2016,4,25)
  end
end
