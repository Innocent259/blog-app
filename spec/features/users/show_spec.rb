require 'rails_helper'
RSpec.describe 'users#show', type: :feature do
  before(:each) do
    @user = User.create(name: 'Lilly', photo: 'lilly.jpg', bio: 'Software Developer', posts_counter: 0)
    @posts = [
      Post.create(author: @user, title: 'Post 1', text: 'This is Post 1'),
      Post.create(author: @user, title: 'Post 2', text: 'This is Post 2'),
      Post.create(author: @user, title: 'Post 3', text: 'This is Post 3')
    ]
    visit user_path(@user)
  end
  it 'displays the user\'s bio' do
    expect(page).to have_content(@user.bio)
  end
  it 'displays the user\'s posts' do
    @posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
    end
  end
  it 'displays a "See all posts" button if the user has more than 3 posts' do
    expect(page).to have_selector('button', text: 'See all posts')
  end
  it 'redirects to the user posts index page when "See all posts" button is clicked' do
    visit user_path(@user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end










