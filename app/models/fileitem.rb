# == Schema Information
#
# Table name: fileitems
#
#  id           :integer          not null, primary key
#  directory_id :integer
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  bindata      :binary
#

class Fileitem < ActiveRecord::Base
  belongs_to :directory

  has_many :events

  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }

  def pathname
    "#{self.directory.pathname}/#{self.name}"
  end
end
