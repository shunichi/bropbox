class SharedDirectory < ActiveRecord::Base
  belongs_to :directory
  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :directory_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
