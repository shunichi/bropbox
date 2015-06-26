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
  has_one :user, through: :directory

  has_many :events
  has_many :shared_files

  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }

  scope :match, ->(q) {
    where{(name.like "%#{q}%")}
  }

  def pathname
    "#{self.directory.pathname}/#{self.name}"
  end

  def move(destination_directory)
    self.update(directory_id: destination_directory.id)
  end

  def copy(destination_directory)
    destination_directory.files.create(name: self.name, bindata: self.bindata)
  end
end
