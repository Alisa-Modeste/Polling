class Question < ActiveRecord::Base
  attr_accessible :poll_id, :text
  validates :text, presence: true

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  def results
    responses = Response.responses_for_question(self.id)
    choices = AnswerChoice.answer_choices_for_question(self.id)
    
    choice_hash = {}
    
    choices.each do |choice|
      choice_hash[ choice.id ] = choice.text
    end
    
    response_hash = {}

    responses.each do |r|
      new_key = choice_hash[ r.answer_choice_id ]


      if response_hash.key?(new_key)
        response_hash[new_key] += 1
      else
        response_hash[new_key] = 1
      end
    end

    response_hash
    end

end