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
                     "#{self.path} が作られました"
                   when 'update'
                     "#{self.path} の名前が #{self.destination_path} に変更されました"
                   when 'destroy'
                     "#{self.path} が削除されました"
                   when 'move'
                     "#{self.path} が #{self.destination_path} に移動しました"
                   when 'copy'
                     "#{self.path} が #{self.destination_path} に複製されました"
                   end
  end
end
