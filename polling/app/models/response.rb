class Response < ActiveRecord::Base
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )



  def existing_responses
    self.find_by_sql(<<-SQL, )
      SELECT
        responses.*
      FROM
        resonses
      JOIN answer_choices
      ON
      answer_choices.id = responses.anser
    SQL

  end

end
