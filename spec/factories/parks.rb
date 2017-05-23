FactoryGirl.define do
  factory :park do
    sequence(:name) { |n| "National Park 0#{n}" }
    park_type "National Park"
    state Park::STATES.sample
  end
end
