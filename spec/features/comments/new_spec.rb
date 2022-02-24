require 'rails_helper'

RSpec.describe 'New Comment Page', type: :feature do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')
      visit login_path

      fill_in(:email, with: 'david@email.com')
      fill_in(:password, with: 'password123')

      click_button 'Log In'
    end

    it 'allows users to comment on posts' do
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

    it 'sad path: doesnt allows user to submit blank comments' do
      post = create(:post, user_id: @user_1.id)
      visit root_path

      within("#comment-#{post.id}") do
        click_button 'Comment'
      end
      click_button 'Submit'

      expect(current_path).to eq("/posts/#{post.id}/comments")
      expect(page).to have_content("1 error prohibited this comment from being saved")
      expect(page).to have_content("Body can't be blank")
    end
  end
end
