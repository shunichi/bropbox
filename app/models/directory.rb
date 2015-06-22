class Directory < ActiveRecord::Base
  belongs_to :user

  has_many :files, class_name: 'Fileitem', dependent: :destroy
  has_many :events

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }

  after_destroy :destroy_children

  has_ancestry

  private

  def destroy_children
    children.each { |dir| dir.destroy }
  end
end
