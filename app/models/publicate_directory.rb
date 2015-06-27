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

class PublicateDirectory < ActiveRecord::Base
  include PublicItem

  belongs_to :directory

  validates :directory_id, presence: true
  validates_uniqueness_of :directory_id
end
