class AddPlayedAtToHowlers < ActiveRecord::Migration
  def change
    add_column :howlers, :played_at, :timestamp
  end
end
