require 'rails_helper'

RSpec.describe 'Welcome Index Page', type: :feature do
  describe 'view' do
    it 'has a title and links to login or regester' do
      visit root_path

      expect(page).to have_content("Welcome to Robin's Ruby on Rails Code Project!")
      expect(page).to have_content("Users can create posts, comment on others' posts, and delete posts.")
      expect(page).to have_content("Please Log in or register, by using one of the links above, to get started.")
    end

    it 'includes a link to create a new user' do
      visit root_path

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

      click_link 'Log In'
      expect(current_path).to eq("/login")

      fill_in :password, with: 'password12345'

      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("User does not exist. Please try again.")
    end

    it 'sad path: user attempts to log in with no existing user' do
      visit root_path

      click_link 'Log In'
      expect(current_path).to eq("/login")

      fill_in :email, with: 'david@email.com'
      fill_in :password, with: 'password12345'

      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("User does not exist. Please try again.")
    end

    it 'sad path: user attempts to log in with invalid username or password' do
      user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')

      visit root_path

      click_link 'Log In'
      expect(current_path).to eq("/login")

      fill_in :email, with: 'david@email.com'
      click_button 'Log In'

      expect(current_path).to eq("/login")
      expect(page).to have_content("Email or password is incorrect. Please try again.")
    end
  end
end
