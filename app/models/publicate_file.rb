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

class PublicateFile < ActiveRecord::Base
  include PublicItem

  belongs_to :fileitem

  validates :fileitem_id, presence: true
  validates_uniqueness_of :fileitem_id
end
