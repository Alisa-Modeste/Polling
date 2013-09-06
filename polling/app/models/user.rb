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

  def self.users_polls

  User.joins(:answer_choices )
  end
end