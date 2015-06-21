require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create' do
    subject { create(:user) }

    it 'Directory が生成される' do
      expect { subject }.to change(Directory, :count).by(1)
    end

    it '生成された Directory は root である' do
      expect(subject.directories.first.root?).to be_truthy
    end
  end
end
