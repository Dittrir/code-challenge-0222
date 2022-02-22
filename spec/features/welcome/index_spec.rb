require 'rails_helper'

RSpec.describe 'Welcome Index Page', type: :feature do
  describe 'view' do
    it 'includes a button to create a new user' do
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
  end
end
