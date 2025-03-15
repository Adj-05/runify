class ChangeAverageSpeedToBeString < ActiveRecord::Migration[7.1]
  def change
    change_column :trainings, :average_speed, :string
  end
end
