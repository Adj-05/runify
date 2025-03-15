class TrainingsController < ApplicationController

  def new
    @training = Training.new
  end

  def index
    @trainings = current_user.trainings.order(created_at: :desc)
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


  def preview
    @training = Training.find(params[:id])
  end

  def confirm
    @training = Training.find(params[:id])
    @training.update(confirmed: true) # création colonne "confirmed" + migration
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
    redirect_to playlists_path, notice: "Your playlist is ready, enjoy your session!"
    rescue StandardError => e
      Rails.logger.error "Error while creating your playlist : #{e.message}"
      flash[:alert] = "Your playlist couldn't be created but your training has been saved"
    end

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
    params.require(:training).permit(:average_speed, :training_duration, :music_genre, :name)
  end
end
