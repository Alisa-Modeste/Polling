class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question
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
    # if existing_responses.empty? ||
 #      errors[:response] << "can't answer twice"
 #    end
 #
 #    existing_responses.answer_choices

    result = existing_responses
    p "res #{result[0].id}"
    p "sel #{self.id}"
    unless result[0].id == self.id
      errors[:response] << "can't answer twice"
    end
  end


  def au
    Response.joins(:user).where("question_id = ? AND users.id = ?", self.question_id, self.user_id)
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
