require 'rails_helper'

RSpec.describe 'User Dashboard Page', type: :feature do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')
      @user_2 = User.create!(name: "Pamala", email: "Pamela@email.com", password: 'password123', password_confirmation: 'password123')
      visit login_path

      fill_in(:email, with: 'david@email.com')
      fill_in(:password, with: 'password123')

      click_button 'Log In'
    end

    it 'has a title and links to return to home' do
      expect(page).to have_content("Welcome, David!")
      expect(page).to have_content("David's Dashboard")

      click_link('Home')

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Logout")
    end

    it 'has a link to log out' do
      click_link('Logout')

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Log In")
    end

    it 'includes posts from that user' do
      create(:post, user_id: @user_1.id, title: "Test Post")
      visit dashboard_path

      expect(page).to have_content("Test Post")
    end

    it 'includes comments for each post' do
      post = create(:post, user_id: @user_1.id, title: "Test Post")
      comment = create(:comment, post_id: @post.id, user_id: @user_2.id, body: "Test Comment")
      visit dashboard_path

      expect(page).to have_content("Test Comment")
    end
  end
end
