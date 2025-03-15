class AddConfirmedToTrainings < ActiveRecord::Migration[7.1]
  def change
    add_column :trainings, :confirmed, :boolean
  end
end
