class AddReferencesToPlaylists < ActiveRecord::Migration[7.1]
  def change
    add_reference :playlists, :training, foreign_key: true
  end
end
