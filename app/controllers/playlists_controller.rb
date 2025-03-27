class PlaylistsController < ApplicationController
  def index
  end

  def create
    tempo = params[:tempo]
    genre = params[:genre]
    duration = params[:duration].to_i * 60 # Convertit en secondes

    # Recherche de titres en fonction des critères
    tracks = find_tracks(genre, duration)

    if tracks.any?
      playlist = create_spotify_playlist(tracks)
      redirect_to playlist["external_urls"]["spotify"], notice: "Your playlist has been created!"
    else
      redirect_to root_path, alert: "We could not find any track."
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end


  private

  def find_tracks(tempo, genre, duration)
    features_map = {
      "energetic" => { energy: 0.8 },
      "calm" => { energy: 0.2 },
      "sad" => { valence: 0.2 },
      "party" => { danceability: 0.8 }
    }

    tempo_features = features_map[tempo] || {}

    results = RSpotify::Recommendations.generate(
      min_tempo: bpm_min,
      max_tempo: bpm_max,
      seed_genres: [genre],
      target_energy: tempo_features[:energy],
      target_valence: tempo_features[:valence],
      target_danceability: tempo_features[:danceability]
    )

    tracks = []
    total_duration = 0

    results.tracks.shuffle.each do |track|
      next if total_duration + (track.duration_ms / 1000) > duration
      tracks << track.uri
      total_duration += track.duration_ms / 1000 # Convertir en secondes
    end

    tracks
  end


  def create_spotify_playlist(tracks)
    user = RSpotify::User.new(session[:spotify_auth])
    playlist = user.create_playlist!('Playlist generated', public: false)
    playlist.add_tracks!(tracks)
    playlist
  end


  def destroy
  end
end
