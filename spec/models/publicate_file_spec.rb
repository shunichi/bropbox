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

require 'rails_helper'

RSpec.describe PublicateFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
