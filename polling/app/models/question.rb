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


  #question > answerchoice > response
  def results
    responses = Response.responses_for_question(self.id)
    hash = {}

    puts "this is for testing..."
    p Question.joins(:answer_choices)

    responses.each do |r|
      new_key = r.answer_choice_id


      if hash.key?(new_key)
        hash[new_key] += 1
      else
        hash[new_key] = 1
      end
    end

    hash
  end

end