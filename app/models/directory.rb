# == Schema Information
#
# Table name: directories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string           not null
#  ancestry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
