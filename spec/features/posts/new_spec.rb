require 'rails_helper'

RSpec.describe 'New Post Page', type: :feature do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')
      visit login_path

      fill_in(:email, with: 'david@email.com')
      fill_in(:password, with: 'password123')

      click_button 'Log In'
    end

    it 'includes a link to create a new post' do
      visit root_path
      click_button 'Create a New Post'

      fill_in :title, with: 'Robins New Post'
      fill_in :body, with: 'Heres the body of the post'

      click_button 'Post'

      visit root_path
      expect(current_path).to eq(root_path)
    end

    it 'sad path: doesnt allow post creation if fields are blank' do
      visit root_path
      click_button 'Create a New Post'

      click_button 'Post'

      expect(page).to have_content("2 errors prohibited this post from being saved")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Body can't be blank")
    end
  end
end
