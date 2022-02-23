# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user_1 = User.create!(name: "Rodrigo", email: "rodrigo@email.com", password: 'password123', password_confirmation: 'password123')
@user_2 = User.create!(name: "Sarah", email: "sarah@email.com", password: 'password123', password_confirmation: 'password123')
@user_3 = User.create!(name: "George", email: "george@email.com", password: 'password123', password_confirmation: 'password123')
@user_4 = User.create!(name: "Stella", email: "stella@email.com", password: 'password123', password_confirmation: 'password123')

@post_1 = @user_1.posts.create!(title: "Post 1", body: "Post 1's Body")
@post_2 = @user_2.posts.create!(title: "Post 2", body: "Post 2's Body")
@post_3 = @user_3.posts.create!(title: "Post 3", body: "Post 3's Body")
@post_4 = @user_4.posts.create!(title: "Post 4", body: "Post 4's Body")

@comment_1 = @post_1.comments.create!(user_id: @user_2.id, body: "This is awesome!")
@comment_2 = @post_2.comments.create!(user_id: @user_3.id, body: "This is awesome!")
@comment_3 = @post_3.comments.create!(user_id: @user_4.id, body: "This is awesome!")
@comment_4 = @post_4.comments.create!(user_id: @user_1.id, body: "This is awesome!")
