class AddDestinationPathToEvents < ActiveRecord::Migration
  def change
    add_column :events, :destination_path, :string
  end
end
