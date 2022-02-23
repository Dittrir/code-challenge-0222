class User < ApplicationRecord
  has_many :posts
  has_many :comments, through: :posts

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
            :presence => {message: "can't be blank"},
            :uniqueness => true
  validates :name,
            :presence => {message: "can't be blank"}
  validates :password_digest,
            :presence => {message: "can't be blank"}

  has_secure_password

  enum role: %w(default manager admin)
end
