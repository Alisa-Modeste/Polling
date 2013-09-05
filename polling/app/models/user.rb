class User < ActiveRecord::Base
  attr_accessible :user_name #delete this later?
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :polls,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  # def
end