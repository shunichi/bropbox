FactoryGirl.define do
  factory :directory do
    association :user
    name Faker::Lorem.word
  end
end
