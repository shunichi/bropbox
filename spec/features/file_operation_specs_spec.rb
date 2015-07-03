require 'rails_helper'

RSpec.feature 'ファイル 制御', type: :feature do
  given!(:user) { create(:user) }

  before do
    sign_in user
    visit root_path
  end

  feature '新規作成（ アップロード ）' do
    subject { upload_file_to_root_directory(user) }

    scenario 'Fileitem モデルが一件増える' do
      expect { subject }.to change(Fileitem, :count).by(1)
    end

    scenario 'イベントログが記録される' do
      expect { subject }.to change(Event, :count).by(1)
    end
  end

  feature '名前の変更' do
    given(:new_filename) { 'foo' }

    before do
      upload_file_to_root_directory(user)
    end

    subject do
      visit root_path
      click_link '名前を変更'
      fill_in 'fileitem[name]', with: new_filename
      find('[name=commit]').click
    end

    scenario 'Fileitem モデルの件数は変わらない' do
      expect { subject }.to change(Fileitem, :count).by(0)
    end

    scenario 'イベントログが記録される' do
      expect { subject }.to change(Event, :count).by(1)
      visit events_path
      expect(page).to have_content("#{new_filename} に変更")
    end
  end

  feature '削除', js: true do
    pending 'js: true で attach_file が必ず失敗するのでどうテストしようか' do
      before do
        upload_file_to_root_directory(user)
      end

      subject do
        visit root_path
        find('[data-method=delete]').click
        expect(page).to have_css('.alert-success')
      end

      scenario 'Fileitem モデルがひとつ減る' do
        expect { subject }.to change(Fileitem, :count).by(-1)
      end

      scenario 'イベントログが記録される' do
        expect { subject }.to change(Event, :count).by(-1)
        visit events_path
        expect(page).to have_content("#{Fileitem.first.pathname} が削除されました")
      end
    end
  end
end
