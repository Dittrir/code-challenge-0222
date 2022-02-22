require 'rails_helper'

RSpec.describe 'Register New User Page', type: :feature do
  describe 'view' do
    it 'includes a link to create a new user' do
      visit register_path

      fill_in :name, with: 'Robin'
      fill_in :email, with: 'robin@email.com'
      fill_in :password, with: 'password12345'
      fill_in :password_confirmation, with: 'password12345'

      click_button 'Submit'

      expect(page).to have_content("Robin's Dashboard")
      expect(current_path).to eq(dashboard_path(User.last))
    end

    it 'sad path: doesnt allow user creation if fields are blank' do
      visit register_path

      fill_in :name, with: 'Robin'

      click_button 'Submit'

      expect(current_path).to eq(register_path)

      expect(page).to have_content("4 errors prohibited this post from being saved")
      expect(page).to have_content("Email is invalid")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password digest can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end
end
