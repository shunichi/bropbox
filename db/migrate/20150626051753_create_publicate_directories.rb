class CreatePublicateDirectories < ActiveRecord::Migration
  def change
    create_table :publicate_directories do |t|
      t.references :directory, index: true, foreign_key: true
      t.string :access_token, null: false

      t.timestamps null: false
    end
  end
end
