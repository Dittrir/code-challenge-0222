class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body,
            :presence => {message: "can't be blank"}

  def author(id)
    User.find(id).name
  end
end
