class Poll < ActiveRecord::Base
  attr_accessible :title, :author
  validate :title, presence: true
  validate :author, presence: true
  #polls by the same author should be unique?

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :questions,
    class_name: "Question",
    foreign_key: :poll_id,
    primary_key: :id
  )
end