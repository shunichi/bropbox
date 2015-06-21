class Directory < ActiveRecord::Base
  belongs_to :user

  has_many :fileitems

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }
  validate :root_cannot_duplicate

  has_ancestry

  private

  def root_cannot_duplicate
    errors.add(:base, 'root directory has already exists') if user.root_directory.present?
  end
end
