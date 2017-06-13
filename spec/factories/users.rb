FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    sequence(:name) { |n| "User 0#{n}" }
    oauth_token "MyToken"
    oauth_expires_at "2017-05-22 10:34:31"
  end
end
