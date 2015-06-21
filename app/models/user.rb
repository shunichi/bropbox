class User < ActiveRecord::Base
  has_many :directories

  after_create :create_root_directory

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def root_directory
    directories.roots.first
  end

  private

  def create_root_directory
    directories.create!(name: '/')
  end
end
