class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.string :ancestry

      t.timestamps null: false
    end
  end
end
