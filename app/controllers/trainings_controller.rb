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
    @training.save
    redirect_to training_preview_path(@training)

    # if @training.save
    #   @playlist = Playlist.create_from_api!(user: current_user, name: "You got this 💪🏾", count: 25, training: @training, bpm_min: @training.bpm_min, bpm_max:  @training.bpm_max, dur_min: @training.training_duration, dur_max: @training.training_duration)
    #   p "//////////////////////////////////////////////////////////////////////////////// #{@training.bpm_min} #{@training.bpm_max}"
    #   redirect_to training_path(@training)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  private

  def training_params
    params.require(:training).permit(:average_speed, :training_duration, :music_genre)
  end

end
