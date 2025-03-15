class AddStartTimeToTrainings < ActiveRecord::Migration[7.1]
  def change
    add_column :trainings, :start_time, :datetime
  end
end
