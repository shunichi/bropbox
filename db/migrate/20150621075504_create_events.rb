class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :directory, index: true, foreign_key: true, null: false
      t.references :fileitem, index: true, foreign_key: true
      t.string :url
      t.string :message

      t.timestamps null: false
    end
  end
end
