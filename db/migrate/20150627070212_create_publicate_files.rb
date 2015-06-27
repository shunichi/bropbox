class CreatePublicateFiles < ActiveRecord::Migration
  def change
    create_table :publicate_files do |t|
      t.references :fileitem, index: true, foreign_key: true
      t.string :access_token, null: false

      t.timestamps null: false
    end
    add_index :publicate_files, :access_token, unique: true
  end
end
