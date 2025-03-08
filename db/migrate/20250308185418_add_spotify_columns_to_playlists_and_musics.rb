class AddSpotifyColumnsToPlaylistsAndMusics < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :spotify_id, :string
    add_column :playlists, :spotify_url, :string
    add_column :playlists, :spotify_uri, :string

    add_column :musics, :spotify_id, :string
    add_column :musics, :spotify_url, :string
    add_column :musics, :spotify_uri, :string
  end
end
