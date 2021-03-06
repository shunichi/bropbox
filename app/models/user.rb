# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :directories
  has_many :events
  has_many :files, class_name: 'Fileitem', through: :directories
  has_many :shared_directories
  has_many :shared_files

  after_create :create_root_directory

  scope :others, ->(my_id) {
    where { (id.not_eq my_id) }
  }

  def root_directory
    directories.roots.first
  end

  private

  def create_root_directory
    directories.create!(name: '/')
  end
end
