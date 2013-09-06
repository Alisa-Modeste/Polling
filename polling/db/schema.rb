# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130905193440) do

  create_table "answer_choices", :force => true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "response_id"
  end

  add_index "answer_choices", ["question_id"], :name => "index_answer_choices_on_question_id"

  create_table "polls", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "author_id"
  end

  create_table "questions", :force => true do |t|
    t.integer  "poll_id"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["poll_id"], :name => "index_questions_on_poll_id"

  create_table "responses", :force => true do |t|
    t.integer  "question_id"
    t.integer  "answer_choice_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "responses", ["question_id", "answer_choice_id"], :name => "index_responses_on_question_id_and_answer_choice_id"

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
