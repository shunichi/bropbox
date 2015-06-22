# == Schema Information
#
# Table name: directories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string           not null
#  ancestry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :directory do
    association :user
    name Faker::Lorem.word
  end
end
