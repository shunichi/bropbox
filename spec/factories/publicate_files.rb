# == Schema Information
#
# Table name: publicate_files
#
#  id           :integer          not null, primary key
#  fileitem_id  :integer
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :publicate_file do
    fileitem nil
access_token "MyString"
  end

end
