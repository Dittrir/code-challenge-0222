class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title,
            :presence => {message: "can't be blank"}
  validates :body,
            :presence => {message: "can't be blank"}
end
