FactoryGirl.define do
  factory :vacation do
    sequence(:name) { |n| "Vacation 0#{n}" }
    location Park::STATES.sample
    public true
    start_date (Date.today - 14)
    end_date (Date.today - 9)
  end
end
