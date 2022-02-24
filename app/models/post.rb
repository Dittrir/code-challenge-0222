class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title,
            :presence => {message: "can't be blank"}
  validates :body,
            :presence => {message: "can't be blank"}

  def author(id)
    User.find(id).name
  end

  def self.order_by_most_recent
    order(created_at: :desc)
  end
end
