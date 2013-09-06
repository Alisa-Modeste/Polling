class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question, :author_not_responding
  attr_accessible :id

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

 has_one(
   :answer_choice,
   class_name: "AnswerChoice",
   foreign_key: :response_id,
   primary_key: :id
 )

 def self.responses_for_question(question_id)

   Response.joins("JOIN questions ON responses.question_id = questions.id")
 end

  def existing_responses
    Response.joins(:user).where("question_id = ?", self.question_id)
  end

  def respondent_has_not_already_answered_question

    result = existing_responses

    unless self.id.nil? || result[0].id == self.id
      errors[:response] << "can't answer twice"
    end
  end

  def users_polls
    User.users_polls.where("users.id = ?", self.user_id)
  end


  def author_not_responding
    unless users_polls.empty?
      errors[:response] << "can't answer own poll"
    end
  end

end
