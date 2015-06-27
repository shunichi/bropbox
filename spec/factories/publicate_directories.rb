# == Schema Information
#
# Table name: publicate_directories
#
#  id           :integer          not null, primary key
#  directory_id :integer
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :publicate_directory do
    directory nil
access_token "MyString"
  end

end
