class CreatePlaylistMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :playlist_musics do |t|
      t.references :playlists, null: false, foreign_key: true
      t.references :musics, null: false, foreign_key: true

      t.timestamps
    end
  end
end
