class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :directory_id
      t.integer :fileitem_id
      t.string :request_method, null: false
      t.string :request_url, null: false
      t.string :action, null: false
      t.string :message

      t.timestamps null: false
    end
  end
end
