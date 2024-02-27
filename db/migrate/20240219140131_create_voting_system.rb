class CreateVotingSystem < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.bigint "user_id", null: false
      t.bigint "question_id", null: false
      t.boolean "vote_type", null: false
      t.index ["user_id"], name: "index_votes_on_user_id"
      t.index ["question_id"], name: "index_votes_on_question_id"

      t.timestamps
    end
    create_table :vote_questions do |t|
      t.string "title"
      t.datetime "ends_at", null: false

      t.timestamps
    end
  end
end
