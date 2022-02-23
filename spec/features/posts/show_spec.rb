require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  describe 'view' do
    before(:each) do
      @user_1 = User.create!(name: "David", email: "david@email.com", password: 'password123', password_confirmation: 'password123')
      @user_2 = User.create!(name: "Pamala", email: "Pamela@email.com", password: 'password123', password_confirmation: 'password123')
      visit login_path

      fill_in(:email, with: 'david@email.com')
      fill_in(:password, with: 'password123')

      click_button 'Log In'
    end

    it 'shows a post' do
      post = create(:post, user_id: @user_1.id)
      visit root_path

      within("#post-#{post.id}") do
        click_link "Post #: #{post.id}"
        expect(current_path).to eq("/posts/#{post.id}")
      end

      expect(page).to have_content("#{post.title}")
      expect(page).to have_content("#{post.body}")
    end

    it 'allows user to comment on a post' do
      post = create(:post, user_id: @user_1.id)
      visit "/posts/#{post.id}"

      click_link 'Comment'
      expect(current_path).to eq("/posts/#{post.id}/comments/new")

      fill_in :body, with: "Awesome!"
      click_button 'Submit'

      expect(page).to have_content("Awesome!")
    end
  end
end
