class AnswerChoice < ActiveRecord::Base
  attr_accessible :question_id, :text
  validates :text, presence: true

  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :response,
    class_name: "Response",
    foreign_key: :response_id,
    primary_key: :id
  )
end