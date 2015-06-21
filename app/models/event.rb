class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :directory
  belongs_to :fileitem

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fileitem_id, numericality: { only_integer: true, greater_than: 0 }
end
