class Addcolumn < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :title, :string
    remove_column :playlists, :favorite
    add_column :trainings, :favorite_playlist, :boolean
  end
end
