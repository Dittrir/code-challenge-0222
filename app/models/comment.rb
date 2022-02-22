class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, through: :post

  validates :body,
            :presence => {message: "can't be blank"}
end
