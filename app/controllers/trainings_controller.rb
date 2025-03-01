class TrainingsController < ApplicationController

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    @training.user_id = current_user.id
    if @training.save
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
