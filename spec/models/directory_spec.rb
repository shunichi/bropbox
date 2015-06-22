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
  let(:user) { create(:user) }
  let(:parent_dir) { create(:directory, parent: user.root_directory) }
  let(:child_dir) { create(:directory, parent: parent_dir) }

  describe 'destroy' do
    before do
      grandchild_dir = create(:directory, parent: child_dir)
      grandchild_dir.files.create!(name: Faker::Lorem.word, bindata: 0)
      parent_dir.files.create!(name: Faker::Lorem.word, bindata: 0)
      child_dir.files.create!(name: Faker::Lorem.word, bindata: 0)
    end

    subject { parent_dir.destroy }

    it '配下のディレクトリも全て削除される' do
      expect { subject }.to change(Directory, :count).by(-3)
    end

    it '配下のファイルも全て削除される' do
      expect { subject }.to change(Fileitem, :count).by(-3)
    end
  end

  describe 'pathname' do
    let(:dir) { create(:directory, parent: child_dir) }

    it 'root directory からの path 文字列を返す' do
      expect(dir.pathname).to eq "/#{parent_dir.name}/#{child_dir.name}/#{dir.name}"
    end
  end
end
