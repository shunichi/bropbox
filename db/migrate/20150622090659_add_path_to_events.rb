class AddPathToEvents < ActiveRecord::Migration
  def change
    add_column :events, :path, :string, null: false
  end
end
