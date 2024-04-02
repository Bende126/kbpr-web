class ChangeVoteFieldName < ActiveRecord::Migration[7.0]
  def change
    change_table :votes do |t|
      t.rename :question_id, :vote_question_id
    end
  end
end
