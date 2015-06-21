class AddBindataToFileitems < ActiveRecord::Migration
  def change
    add_column :fileitems, :bindata, :binary
  end
end
