class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def index
    start_date = params.fetch(:start_date, Date.today).to_date

    # Charger les trainings créés dans le mois affiché
    @trainings = Training.where(created_at: start_date.beginning_of_month..start_date.end_of_month)
  end


end
