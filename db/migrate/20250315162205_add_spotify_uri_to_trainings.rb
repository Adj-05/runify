class AddSpotifyUriToTrainings < ActiveRecord::Migration[7.1]
  def change
    add_column :trainings, :spotify_uri, :string
  end
end
