class RemovePlaylistIdfromTraining < ActiveRecord::Migration[7.1]
  def change
    remove_reference :trainings, :playlist, foreign_key: true
  end
end
