namespace :sampledata do
  desc 'create sampledata'

  task create: :environment do
    create_users
    User.all.each { |user| create_directories(user, 3) }
    create_files(20)
  end

  def create_users
    User.create!(email: 'soutetsu@gmail.com', password: 'xxx')
    User.create!(email: 'dev.tetsu@gmail.com', password: 'xxx')
  end

  def create_directories(user, depth)
    parent = user.root_directory
    depth.times do
      3.times { |n| user.directories.create!(name: "dirname-#{n}", parent: parent) }
      parent = parent.children.sample
    end
  end

  def create_files(count)
    count.times do |n|
      dir = User.all.sample.root_directory.children.sample
      dir.files.create!(name: "file-#{n}.#{%w(doc xls jpg).sample}", bindata: 0)
    end
  end
end
