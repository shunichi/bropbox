require 'rails_helper'

RSpec.describe Directory, type: :model do
  let!(:user) { create(:user) }

  context 'root directory が既に存在する場合' do
    describe 'root directory を更に作成しようとした場合' do
      let(:directory) { build(:directory, user_id: user.id) }

      it '無効となる' do
        directory.valid?
        expect(directory.errors[:base]).not_to be_empty
      end
    end
  end
end
