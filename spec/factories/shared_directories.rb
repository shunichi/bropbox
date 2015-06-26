# == Schema Information
#
# Table name: shared_directories
#
#  id           :integer          not null, primary key
#  directory_id :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :shared_directory do
    directory nil
user nil
  end

end
