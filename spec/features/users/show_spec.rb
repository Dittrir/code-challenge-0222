require 'rails_helper'

RSpec.describe 'User Dashboard Page', type: :feature do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')

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
  end
end
