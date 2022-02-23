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

    it 'includes posts' do
      post = create(:post, user_id: @user_1.id, title: "Test Post")
      visit root_path

      within("#post-#{post.id}") do
        expect(page).to have_content("Author: David")
        expect(page).to have_content("Title: Test Post")
        expect(page).to have_content("Body: #{post.body}")
      end
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
        click_button 'Comment'
        expect(current_path).to eq("/posts/#{post.id}/comments/new")
      end

      fill_in :body, with: "Hey thats a great idea!"
      click_button 'Submit'

      expect(page).to have_content("Hey thats a great idea!")
    end

    it 'sad path: user cant see posts unless logged in' do
      click_link "Logout"
      post = create(:post, user_id: @user_1.id)
      visit root_path

      expect(page).to_not have_content("Here are the posts!")
      expect(page).to_not have_content(post.title)
    end

    it 'allows users to create new posts' do
      visit root_path

      click_button 'Create a New Post'

      fill_in :title, with: 'Another day at the office!'
      fill_in :body, with: 'Who is stoked for the weekend?'
      click_button 'Post'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Another day at the office!")
      expect(page).to have_content("Who is stoked for the weekend?")
    end

    it 'sad path: doesnt allow user to create a post without ' do
      visit root_path

      click_button 'Create a New Post'

      fill_in :title, with: 'Another day at the office!'
      fill_in :body, with: 'Who is stoked for the weekend?'
      click_button 'Post'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Another day at the office!")
      expect(page).to have_content("Who is stoked for the weekend?")
    end

    it 'allows user to return to their dashboard ' do
      visit root_path

      click_link 'My Dashboard'

      expect(current_path).to eq(dashboard_path)
    end
  end
end
