require 'rails_helper'

RSpec.feature 'フォルダ 制御', type: :feature do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  scenario '新規作成' do
    expect {
      create_parent_and_child_directories
    }.to change(Directory, :count).by(2)
  end

  scenario '削除', js: true do
    create_parent_and_child_directories
    visit root_path
    expect {
      find('[data-method=delete]').click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_css('.alert-success')
    }.to change(Directory, :count).by(-2)
  end

  scenario '名称変更' do
    create_parent_and_child_directories
    visit roo_path
    fill_in 'directory[name]', with: parent_directory_name
  end
end
