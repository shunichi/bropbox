class SharedFile < ActiveRecord::Base
  belongs_to :fileitem
  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fileitem_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
