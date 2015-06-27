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
  has_ancestry

  belongs_to :user

  has_many :files, class_name: 'Fileitem', dependent: :destroy
  has_many :events
  has_many :shared_directories
  has_many :publicate_directories

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 255 }

  after_destroy :destroy_children

  scope :match, ->(q) {
    where { (name.like "%#{q}%") }
  }

  def pathname
    path.each.inject([]) { |arr, dir| arr<<dir.name.gsub('/', '') }.join('/')
  end

  def move(destination)
    self.update(parent: destination)
  end

  def copy(destination)
    new_parent = destination.user.directories.create(name: self.name, parent: destination)
    copy_fileitems(new_parent)
    self.children.each do |child|
      child.copy(new_parent)
    end
  end

  def share_for(user)
    self.shared_directories.create(user_id: user.id)
  end

  def shared_for?(user)
    dir = user.shared_directories
    dir.find_by(directory_id: self.id).present? || dir.where(directory_id: self.ancestor_ids).present?
  end

  def publicate_for(email)
    self.publicate_directories.create(email: email)
  end

  private

  def destroy_children
    children.each { |dir| dir.destroy }
  end

  def copy_fileitems(destination)
    self.files.each do |source_file|
      destination.files.create(name: source_file.name, bindata: source_file.bindata)
    end
  end
end
