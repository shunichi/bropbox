# == Schema Information
#
# Table name: publicate_files
#
#  id           :integer          not null, primary key
#  fileitem_id  :integer
#  access_token :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PublicateFile < ActiveRecord::Base
  attr_accessor :email

  belongs_to :fileitem

  validates :fileitem_id, presence: true
  validates :access_token, presence: true
  validates :email, presence: true
  validates_uniqueness_of :fileitem_id

  before_validation :set_access_token

  private

  #TODO: DRY PublicateDirectory#set_access_token と重複
  def set_access_token
    self.access_token = SecureRandom.base64(20)
  end
end
