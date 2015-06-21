class Directory < ActiveRecord::Base
  belongs_to :user

  has_many :files, class_name: 'Fileitem'
  has_many :events

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }

  has_ancestry
end
