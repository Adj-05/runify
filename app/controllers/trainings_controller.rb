class TrainingsController < ApplicationController

  def new
    @training = Training.new
  end

def show
  @training = Training.find(params[:id])
end

  def create
    @training = Training.new(training_params)
    @training.user_id = current_user.id
    if @training.save
      @playlist = Playlist.create_from_api!(user: current_user, name: "test", count: 25, training: @training, bpm_min: @training.average_speed - 20, bpm_max:  @training.average_speed + 20, dur_min: @training.training_duration - 20, dur_max: @training.training_duration + 20)
      p @playlist
      redirect_to training_path(@training)
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def training_params
    params.require(:training).permit(:average_speed, :training_duration, :music_genre)
  end

end
