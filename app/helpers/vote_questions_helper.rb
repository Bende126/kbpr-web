module VoteQuestionsHelper
    def cast_vote(user, question_id, type)
        @vote = Vote.new()
    end
end
