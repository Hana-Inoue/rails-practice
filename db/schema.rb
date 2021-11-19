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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table 'users', force: :cascade do |table|
    table.string 'name', null: false
    table.string 'email', null: false
    table.integer 'gender', null: false
    table.date 'birthday', null: false
    table.string 'password_digest', null: false
    table.boolean 'index_action', default: true, null: false
    table.boolean 'show_action', default: true, null: false
    table.boolean 'new_action', default: true, null: false
    table.boolean 'edit_action', default: false, null: false
    table.boolean 'create_action', default: true, null: false
    table.boolean 'update_action', default: false, null: false
    table.boolean 'destroy_action', default: false, null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
    table.index ['email'], name: 'index_users_on_email', unique: true
  end
end
