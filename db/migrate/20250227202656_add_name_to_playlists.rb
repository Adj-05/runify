class AddNameToPlaylists < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :name, :string
  end
end
