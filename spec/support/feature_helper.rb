module FeatureHelper
  def sign_in(user, password = 'xxx')
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: password
    find('[name=commit]').click
  end

  def create_parent_and_child_directories
    parent_directory_name = 'parent'
    child_directory_name = 'child'
    visit root_path
    click_link '新規フォルダ'
    fill_in 'directory[name]', with: parent_directory_name
    click_on '登録する'
    click_link parent_directory_name
    click_link '新規フォルダ'
    fill_in 'directory[name]', with: child_directory_name
    click_on '登録する'
  end
end
