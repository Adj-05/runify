class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.references :playlist, foreign_key: true, null: false
      t.string :genre
      t.integer :duration
      t.integer :bpm
    end
  end
end
