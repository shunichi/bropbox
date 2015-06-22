# == Schema Information
#
# Table name: shared_files
#
#  id          :integer          not null, primary key
#  fileitem_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SharedFile < ActiveRecord::Base
  belongs_to :fileitem
  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fileitem_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
