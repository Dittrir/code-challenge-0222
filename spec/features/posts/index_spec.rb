require 'rails_helper'

RSpec.describe 'Homepage', type: :feature do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')
      @user_2 = User.create!(name: "Pamala", email: "Pamela@email.com", password: 'password123', password_confirmation: 'password123')
      visit login_path

      fill_in(:email, with: 'david@email.com')
      fill_in(:password, with: 'password123')

      click_button 'Log In'
    end

    it 'has a title and links to login or regester' do
      visit root_path

      click_link 'Logout'

      expect(page).to have_content("Welcome to Robin's Ruby on Rails Code Project!")
      expect(page).to have_content("Users can create posts, comment on others' posts, and delete posts.")
      expect(page).to have_content("Please Log in or register, by using one of the links above, to get started.")
    end

    it 'includes a link to create a new user' do
      visit root_path
      click_link 'Logout'

      click_link 'Register'
      expect(current_path).to eq("/register")

      fill_in :name, with: 'Robin'
      fill_in :email, with: 'robin@email.com'
      fill_in :password, with: 'password12345'
      fill_in :password_confirmation, with: 'password12345'
      click_button 'Submit'

      expect(page).to have_content("Robin's Dashboard")
      expect(current_path).to eq(dashboard_path(User.last))
    end

    it 'sad path: user attempts to log in with one field blank' do
      visit root_path
      click_link 'Logout'

      click_link 'Log In'
      expect(current_path).to eq("/login")

      fill_in :password, with: 'password12345'

      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("User does not exist. Please try again.")
    end

    it 'sad path: user attempts to log in with no existing user' do
      visit root_path
      click_link 'Logout'

      click_link 'Log In'
      expect(current_path).to eq("/login")

      fill_in :email, with: 'roger@email.com'
      fill_in :password, with: 'password12345'

      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("User does not exist. Please try again.")
    end

    it 'sad path: user attempts to log in with invalid username or password' do
      click_link 'Logout'
      user_1 = User.create!(name: "Robin", email: "robin@email.com", password: 'password123', password_confirmation: 'password123')

      visit root_path

      click_link 'Log In'
      expect(current_path).to eq("/login")

      fill_in :email, with: 'david@email.com'
      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("Email or password is incorrect. Please try again.")
    end

    it 'includes posts from that user' do
      create(:post, user_id: @user_1.id, title: "Test Post")
      visit root_path

      expect(page).to have_content("Test Post")
    end

    it 'includes comments for each post' do
      post = create(:post, user_id: @user_1.id, title: "Test Post")
      comment = post.comments.create!(user_id: @user_2.id, body: "Test Comment")
      visit root_path

      expect(page).to have_content("Test Comment")
    end

    it 'allows a user to comment on a post' do
      post = create(:post, user_id: @user_1.id)
      visit root_path
      within("#comment-#{post.id}") do
        fill_in(:comment, with: 'Hey thats a great idea!')
        click_button("Comment")
      end
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Hey thats a great idea!")
    end
  end
end
