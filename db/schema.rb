# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_13_200301) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "musics", force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.string "genre"
    t.integer "duration"
    t.integer "bpm"
    t.string "title"
    t.string "spotify_id"
    t.string "spotify_url"
    t.string "spotify_uri"
    t.index ["playlist_id"], name: "index_musics_on_playlist_id"
  end

  create_table "playlist_musics", force: :cascade do |t|
    t.bigint "playlists_id", null: false
    t.bigint "musics_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["musics_id"], name: "index_playlist_musics_on_musics_id"
    t.index ["playlists_id"], name: "index_playlist_musics_on_playlists_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.bigint "training_id"
    t.string "spotify_id"
    t.string "spotify_url"
    t.string "spotify_uri"
    t.index ["training_id"], name: "index_playlists_on_training_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "average_speed"
    t.integer "training_duration"
    t.string "music_genre"
    t.string "name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "favorite_playlist"
    t.integer "bpm_min"
    t.integer "bpm_max"
    t.index ["user_id"], name: "index_trainings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spotify_name"
    t.string "spotify_token"
    t.string "spotify_refresh_token"
    t.string "spotify_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "musics", "playlists"
  add_foreign_key "playlist_musics", "musics", column: "musics_id"
  add_foreign_key "playlist_musics", "playlists", column: "playlists_id"
  add_foreign_key "playlists", "trainings"
  add_foreign_key "trainings", "users"
end
