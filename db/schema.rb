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
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
    table.index ['email'], name: 'index_users_on_email', unique: true
  end

  create_table 'authorizations', force: :cascade do |table|
    table.string 'controller', null: false
    table.string 'action', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_authorizations', force: :cascade do |table|
    table.references :user, foreign_key: true
    table.references :authorization, foreign_key: true
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_addresses', force: :cascade do |table|
    table.references :user, foreign_key: true
    table.string 'postal_code', null: false
    table.string 'prefecture', null: false
    table.string 'city', null: false
    table.string 'address_line', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_diaries', force: :cascade do |table|
    table.references :user, foreign_key: true
    table.string 'title', null: false
    table.text 'body', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_posts', force: :cascade do |table|
    table.references :user, foreign_key: true
    table.text 'body', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_post_comments', force: :cascade do |table|
    table.references :user_post, foreign_key: true
    table.text 'body', null: false
    table.string 'commented_by', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'tags', force: :cascade do |table|
    table.string 'name', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_post_tags', force: :cascade do |table|
    table.references :user_post, foreign_key: true
    table.references :tag, foreign_key: true
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'events', force: :cascade do |table|
    table.string 'title', null: false
    table.text 'body', null: false
    table.integer 'max_participants', null: false
    table.datetime 'start_at', null: false
    table.datetime 'finish_at', null: false
    table.string 'host', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'todos', force: :cascade do |table|
    table.string 'name', null: false
    table.date 'due_date', null: false
    table.date 'completed_date'
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
    table.index ['due_date'], name: 'index_todos_on_due_date'
  end

  create_table 'schedules', force: :cascade do |table|
    table.string 'name', null: false
    table.datetime 'scheduled_for', null: false
    table.string 'scheduled_by', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  # ????????????????????????
  create_table 'shop_products_unnormalized', force: :cascade do |table|
    table.string 'shop_name', null: false
    table.string 'product_name', null: false
    table.integer 'price', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  # ????????????????????????1
  create_table 'shops', force: :cascade do |table|
    table.string 'name', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  # ????????????????????????2
  create_table 'shop_products', force: :cascade do |table|
    table.references :shop, foreign_key: true
    table.string 'name', null: false
    table.integer 'price', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'products', force: :cascade do |table|
    table.string 'name', null: false
    table.integer 'price', null: false
    table.datetime 'created_at', precision: 6, null: false
    table.datetime 'updated_at', precision: 6, null: false
  end
end
