require "rails_helper"

RSpec.describe Post, type: :model do
  describe "relationships" do
    it { should belong_to :post }
    it { should belong_to(:user).through(:post) }
  end

  describe 'validations' do
    user = User.new(name: "Jim", email: "Jim@test.com", password: "password12345", password_confirmation: "password12345", description: "I love skiing and I live in Bellingham", age: 27)
    post = Post.new(user_id: user.id, title: "The best post ever!", body: "This is the body of the best post ever.")
    subject { Comment.new(post_id: post.id, user_id: user.id, body: "Dang! Thats a really great post!") }

    describe '#body' do
      it { should validate_presence_of(:body) }
      it { should_not allow_value(nil).for(:body) }
    end
  end
end
