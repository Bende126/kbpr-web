json.extract! vote_question, :id, :title, :content, :start_at, :end_at, :created_at, :updated_at
json.url vote_question_url(vote_question, format: :json)
json.content vote_question.content.to_s
