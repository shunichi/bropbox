class Fileitem < ActiveRecord::Base
  belongs_to :directory

  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }
end
