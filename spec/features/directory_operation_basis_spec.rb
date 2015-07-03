require 'rails_helper'

RSpec.feature 'フォルダ 制御', type: :feature do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  feature '新規作成' do
    subject do
      create_parent_and_child_directories
    end

    scenario '新規作成した回数と同じ件数のモデルが生成される' do
      expect { subject }.to change(Directory, :count).by(2)
    end

    scenario '新規作成した回数と同じ件数のイベントログが記録される' do
      expect { subject }.to change(Event, :count).by(2)
      visit events_path
      expect(page).to have_content("#{Directory.first.pathname} が作られました")
      expect(page).to have_content("#{Directory.last.pathname} が作られました")
    end
  end

  feature '名前の変更' do
    let(:new_dirname) { 'foo' }

    before do
      create_parent_and_child_directories
      visit root_path
    end

    subject do
      click_link '名前を変更'
      fill_in 'directory[name]', with: new_dirname
      click_on '更新する'
    end

    scenario 'Directory モデルの件数は変更されない' do
      expect { subject }.to change(Directory, :count).by(0)
      visit root_path
      expect(page).to have_link('foo')
    end

    scenario 'イベントログが記録される' do
      expect { subject }.to change(Event, :count).by(1)
      visit events_path
      expect(page).to have_content("#{new_dirname} に変更")
    end
  end

  feature '削除', js: true do
    before do
      create_parent_and_child_directories
      visit root_path
    end

    subject do
      find('[data-method=delete]').click
      expect(page).to have_css('.alert-success')
    end

    scenario 'サブディレクトリも削除される', js: true do
      expect { subject }.to change(Directory, :count).by(-2)
    end

    scenario 'イベントログが記録される' do
      expect { subject }.to change(Event, :count).by(1)
      visit events_path
      expect(page).to have_content("#{Directory.first.pathname} が削除されました")
    end
  end
end
