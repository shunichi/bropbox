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

require 'rails_helper'

RSpec.describe PublicateDirectory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
