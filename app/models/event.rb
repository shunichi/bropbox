class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :directory
  belongs_to :fileitem
end
