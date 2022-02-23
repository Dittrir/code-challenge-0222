class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title,
            :presence => {message: "can't be blank"}
  validates :body,
            :presence => {message: "can't be blank"}
            
  def author(id)
    User.find(id).name
  end
end
