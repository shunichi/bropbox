class CreateSharedDirectories < ActiveRecord::Migration
  def change
    create_table :shared_directories do |t|
      t.references :directory, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
