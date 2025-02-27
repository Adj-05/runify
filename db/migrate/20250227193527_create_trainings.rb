class CreateTrainings < ActiveRecord::Migration[7.1]
  def change
    create_table :trainings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true
      t.integer :average_speed
      t.integer :training_duration
      t.string :music_genre
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
