# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  directory_id     :integer
#  fileitem_id      :integer
#  request_method   :string           not null
#  request_url      :string           not null
#  action           :string           not null
#  message          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  path             :string           not null
#  destination_path :string
#

class Event < ActiveRecord::Base
  attr_accessor :request

  belongs_to :user

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :directory_id, numericality: { only_integer: true, greater_than: 0 }, if: 'directory_id.present?'
  validates :fileitem_id, numericality: { only_integer: true, greater_than: 0 }, if: 'fileitem_id.present?'
  validates :request_method, presence: true
  validates :request_url, presence: true
  validates :action, presence: true
  validates :path, presence: true

  before_validation :set_request_method, :set_request_url
  before_create :set_message

  paginates_per 10

  private

  def set_request_method
    self.request_method = request.method
  end

  def set_request_url
    self.request_url = request.url
  end

  def set_message
    self.message = case self.action
                   when 'create'
                     "#{self.path} has created."
                   when 'update'
                     "#{self.path} has renamed to #{self.destination_path}."
                   when 'destroy'
                     "#{self.path} has destroyed."
                   when 'move'
                     "#{self.path} has moved to #{self.destination_path}."
                   when 'copy'
                     "#{self.path} has copied to #{self.destination_path}."
                   end
  end
end
