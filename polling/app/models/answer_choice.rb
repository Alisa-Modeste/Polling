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

  def self.answer_choice_for_question(question_id)
  #  Response.joins(:question).

    AnswerChoice.joins("JOIN questions ON answer_choices.question_id = questions.id")
  end
end