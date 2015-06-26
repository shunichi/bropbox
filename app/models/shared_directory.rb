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

class SharedDirectory < ActiveRecord::Base
  belongs_to :directory
  has_one :owner, through: :directory, source: :user
  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates_uniqueness_of :directory_id, scope: :user_id
end
