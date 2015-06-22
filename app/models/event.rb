# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  directory_id :integer          not null
#  fileitem_id  :integer
#  url          :string
#  message      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :directory
  belongs_to :fileitem

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fileitem_id, numericality: { only_integer: true, greater_than: 0 }
end
