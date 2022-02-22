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

    it 'has a title and links to log out and return to home' do
      click_link('Home')

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Logout")
    end
  end
end
