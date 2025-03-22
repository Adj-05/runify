class TrainingsController < ApplicationController

  before_action :set_training, only: [:toggle_favorite]

  def new
    @training = Training.new
  end

  def index
    @trainings = current_user.trainings.order(created_at: :desc)
  end

  def history
    start_date = params.fetch(:start_date, Date.today).to_date

    @trainings = Training.where(start_time: start_date.beginning_of_month..start_date.end_of_month)
  end


def show
  @training = Training.find(params[:id])
end


def create
  @training = Training.new(training_params)
  @training.user_id = current_user.id

  if @training.save
    redirect_to preview_training_path(@training), notice: "Confirm or edit your choices."
  else
    render :new, status: :unprocessable_entity
  end
end
before_action :set_training, only: [:toggle_favorite]

  def toggle_favorite
    @training.update(favorite_playlist: !@training.favorite_playlist)
    respond_to do |format|
      format.html { redirect_to trainings_path }
      format.js
    end
  end

  def favorites
    @favorite_trainings = Training.where(favorite_playlist: true)
  end


  def create
    @training = Training.new(training_params)
    @training.music_genre = @training.music_genre.downcase
    @training.user_id = current_user.id

    if @training.save
      redirect_to preview_training_path(@training, format: :html), notice: "Confirm or edit your choices."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def preview
    @training = Training.find(params[:id])
  end

  def confirm
    @training = Training.find(params[:id])
    @training.update(confirmed: true) # Assurez-vous que la colonne "confirmed" existe dans la DB

    begin
      @playlist = Playlist.create_from_api!(
        user: current_user,
        name: "You got this 💪🏾",
        count: 25,
        training: @training,
        bpm_min: @training.bpm_min,
        bpm_max: @training.bpm_max,
        dur_min: @training.training_duration,
        dur_max: @training.training_duration
      )

      # Supposons que l'API renvoie une URI Spotify pour la playlist
      #if @playlist.respond_to?(:spotify_uri) && @playlist.spotify_uri.present?
      # @training.update(spotify_uri: @playlist.spotify_uri)


      flash[:notice] = "Your playlist is ready, enjoy your session!"
    rescue StandardError => e
      Rails.logger.error "Error while creating your playlist: #{e.message}"
      flash[:alert] = "Your playlist couldn't be created, but your training has been saved."
    end

    redirect_to playlist_path(@playlist)
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id])
    if @training.update(training_params)
      redirect_to preview_training_path(@training), notice: "Updates saved!"
    else
      render :edit
    end
  end

  private

  def training_params
    params.require(:training).permit(:average_speed, :training_duration, :music_genre, :name, :date)
  end

  def set_default_start_time
    self.start_time ||= Time.current # Définit la date actuelle si elle est vide
  end

  def set_training
    @training = Training.find_by(id: params[:id])
    redirect_to trainings_path, alert: "Training not found" if @training.nil?
  end
end
