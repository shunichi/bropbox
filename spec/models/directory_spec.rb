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

require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'destroy' do
    before do
      user       = create(:user)
      @parent_dir = create(:directory, parent: user.root_directory)
      child_dir  = create(:directory, parent: @parent_dir)
      create(:directory, parent: child_dir)
    end

    it '配下のディレクトリも全て削除される' do
      expect { @parent_dir.destroy }.to change(Directory, :count).by(-3)
    end
  end
end
