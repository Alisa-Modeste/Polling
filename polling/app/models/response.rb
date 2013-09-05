class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question, :author_not_responding
  attr_accessible :id

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  # belongs_to(
 #    :answer_choice,
 #    class_name: "AnswerChoice",
 #    foreign_key: :answer_choice_id,
 #    primary_key: :id
 #  )

 has_one(
   :answer_choice,
   class_name: "AnswerChoice",
   foreign_key: :response_id,
   primary_key: :id
 )

 # belongs_to(
 #   :question,
 #   through: :answer_choice)

 def self.responses_for_question(question_id)
 #  Response.joins(:question).

   Response.joins("JOIN questions ON responses.question_id = questions.id")
 end

  def existing_responses
   # User.includes(:response).where()
  # Response.where("question_id = ?", 1).includes(:user)
    Response.joins(:user).where("question_id = ?", self.question_id)
  end

  def respondent_has_not_already_answered_question

    result = existing_responses

    unless self.id.nil? || result[0].id == self.id
      errors[:response] << "can't answer twice"
    end
  end

  def users_polls0
    #Response.joins(:user).where("question_id = ?", self.question_id).joins("JOIN polls ON polls.author_id = #{self.user_id}")
    # Poll.joins(:user).where("author_id = ?", self.author_id).joins("JOIN response ON polls.author_id = #{self.user_id}"
    # :responses)

    #Response.joins(:answer_choice).joins(:question).joins(:poll).where("polls.author_id = ?", self.user_id)
   # Response.joins(:answer_choice).joins(:questions).joins(:polls) #.where("polls.author_id = ?", self.user_id)

   Response.joins("JOIN response ON answer_choices.question_id = questions.id").joins("JOIN polls ON questions.poll_id = polls.id").where("polls.author_id = ?", self.user_id)
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


  def existing_responses1


    # sql_snippet = (<<-SQL, answer_choice_id)
#          SELECT
#            responses.*
#          FROM
#            responses
#          JOIN answer_choices
#          ON
#          answer_choices.response_id = responses.id
#          WHERE
#            answer_choice = ?
#        SQL

    # results = Response.find_by_sql(<<-SQL, answer_choice_id)
  #      SELECT
  #        responses.*
  #      FROM
  #        responses
  #        JOIN answer_choices
  #          ON answer_choices.response_id = response.id
  #      WHERE
  #        answer_choice = ?
  #     SQL
  #   p results
    #
    # #results[0].where("answer_choice = ?", answer_choice_id)
    # Response.find_by_sql(sql_snippet)
  end
