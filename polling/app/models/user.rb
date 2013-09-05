class User < ActiveRecord::Base
  attr_accessible :user_name #delete this later?
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :questions,
    through: :polls

  )

  has_many(
    :answer_choices,
    through: :questions
    )

  # def

  def self.users_polls

   # User.joins(:polls).through
#    ("JOIN response ON answer_choices.question_id = questions.id").joins("JOIN polls ON questions.poll_id = polls.id").where("polls.author_id = ?", self.user_id)
  #  User.joins(:polls => {:responses => {:questions => :answer_choices }})
  User.joins(:answer_choices )
  end
end