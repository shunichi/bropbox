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

  def create_dummy_file
    path = '/tmp/dummy'
    File.write path, Faker::Lorem.word
    path
  end

  def upload_file_to_root_directory(user)
    visit polymorphic_path([:new, user.root_directory, :fileitem])
    attach_file 'fileitem[bindata]', create_dummy_file
    find('[name=commit]').click
  end
end
