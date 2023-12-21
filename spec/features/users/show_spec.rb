require 'rails_helper'

RSpec.describe 'users#show', type: :feature do
  before(:each) do
    @user = User.create(name: 'Innocent', photo: 'innocent.jpg', bio: 'Software Developer', posts_counter: 0)
    @posts = [
      Post.create(author: @user, title: 'Post 1', text: 'This is Post 1'),
      Post.create(author: @user, title: 'Post 2', text: 'This is Post 2'),
      Post.create(author: @user, title: 'Post 3', text: 'This is Post 3')
    ]
    visit user_path(@user)
  end

  it 'displays the user\'s profile picture' do
    expect(page).to have_css("img[src*='innocent.jpg']")
  end

  it 'displays the user\'s username' do
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'displays the user\'s bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'displays the user\'s first 3 posts' do
    @posts.take(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'displays a "See all posts" button if the user has more than 3 posts' do
    expect(page).to have_selector('button', text: 'See all posts')
  end

  it 'redirects to the post\'s show page when a user\'s post is clicked' do
    click_on 'Post 1'
    expect(page).to have_content 'This is Post 1'
  end

  it 'redirects to the user posts index page when "See all posts" button is clicked' do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
