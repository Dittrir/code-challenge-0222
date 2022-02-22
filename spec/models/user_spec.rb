require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :posts}
    it { should have_many(:comments).through(:posts) }
  end

  describe 'validations' do
    subject { User.new(name: "Jim", email: "Jim@email.com", password: "password12345", password_confirmation: "password12345", description: "I love skiing and I live in Bellingham", age: 27) }

    describe '#name' do
      it { should validate_presence_of(:name) }
      it { should_not allow_value(nil).for(:name) }
    end

    describe '#email' do
      it { should validate_presence_of(:email) }
      it { should_not allow_value(nil).for(:email) }
      it { should validate_uniqueness_of(:email) }
    end

    describe '#password' do
      it { should validate_presence_of(:password_digest)}
      it 'tests a new user creation' do
        user = User.create(name: "Jim2", email: "Jim2@email.com", password: "password12345", password_confirmation: "password12345", description: "I love skiing and I live in Bellingham", age: 27)
        expect(user).to_not have_attribute(:password)
        expect(user.password_digest).to_not eq('password123')
      end
    end
  end
end
