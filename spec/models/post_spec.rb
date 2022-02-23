require "rails_helper"

RSpec.describe Post, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :comments }
  end

  describe 'validations' do
    user = User.new(name: "Jim", email: "Jim1@test.com", password: "password12345", password_confirmation: "password12345", description: "I love skiing and I live in Bellingham", age: 27)
    subject { Post.new(user_id: user.id, title: "The best post ever!", body: "This is the body of the best post ever.") }

    describe '#title' do
      it { should validate_presence_of(:title) }
      it { should_not allow_value(nil).for(:title) }
    end

    describe '#body' do
      it { should validate_presence_of(:body) }
      it { should_not allow_value(nil).for(:body) }
    end
  end

  describe 'methods' do
    it '#author' do
      user = create(:user, password: "aaaaa", password_confirmation: "aaaaa")
      post = create(:post, user_id: user.id)

      expect(post.author(user.id)).to eq(user.name)
    end

    it '#order_by_most_recent' do
      user = create(:user, password: "aaaaa", password_confirmation: "aaaaa")
      post1 = create(:post, user_id: user.id)
      post2 = create(:post, user_id: user.id)
      post3 = create(:post, user_id: user.id)

      expect(user.posts.order_by_most_recent).to eq([post3, post2, post1])
    end
  end
end
