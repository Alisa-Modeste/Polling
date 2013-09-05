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

  def users_polls
     # res = Response.joins(:user).where("question_id = ?", self.question_id)
#      res.joins(:user => :polls).where("polls.author_id = ?", self.user_id)
    # Response.joins(:user => :polls).where("question_id = ? AND polls.author_id = ?", self.question_id, user.id)

    Response.joins(:user).where("question_id = ?", self.question_id).joins("JOIN polls ON polls.author_id = responses.user_id")

  end


  def author_not_responding
    #Response.joins(:user).where("question_id = ? AND users.id = ?", self.question_id, self.user_id)

    if users_polls.empty?
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
