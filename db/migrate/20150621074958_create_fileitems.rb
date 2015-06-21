class CreateFileitems < ActiveRecord::Migration
  def change
    create_table :fileitems do |t|
      t.references :directory, index: true, foreign_key: true
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
