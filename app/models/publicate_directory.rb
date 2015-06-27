# == Schema Information
#
# Table name: publicate_directories
#
#  id           :integer          not null, primary key
#  directory_id :integer
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PublicateDirectory < ActiveRecord::Base
  attr_accessor :email

  belongs_to :directory

  validates :access_token, presence: true
  validates :email, presence: true
  validates_uniqueness_of :directory_id

  before_validation :set_access_token

  private

  def set_access_token
    self.access_token = SecureRandom.base64(20)
  end
end
