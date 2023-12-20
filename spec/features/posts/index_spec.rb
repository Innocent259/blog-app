require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  before(:example) do
    @user = User.create(
      name: 'Lilly',
      photo: 'lilly.jpg',
      bio: 'Frontend developer',
      posts_counter: 0
    )

    @posts = [
      Post.create(
        author: @user,
        title: 'Hi',
        text: 'This is first post'
      ),
      Post.create(
        author: @user,
        title: 'Hey',
        text: 'This is second post'
      ),
      Post.create(
        author: @user,
        title: "What's up",
        text: 'This is third post'
      )
    ]

    @comments = [
      Comment.create(user: @user, post: @posts[0], text: 'Hi Tom!'),
      Comment.create(user: @user, post: @posts[0], text: 'How are you'),
      Comment.create(user: @user, post: @posts[1], text: 'What are you doing tonight')
    ]
    @post_counter = @user.posts.count
    visit user_posts_path(user_id: @user.id)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'displays the user username' do
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content(@user.posts_counter.to_s)
  end

  it 'displays a post title' do
    expect(page).to have_content(@posts.first.title)
  end

  it 'displays some of the post body' do
    expect(page).to have_content(@posts.first.text[0..149])
  end

  it 'displays the first comments on a post' do
    expect(page).to have_content(@comments.first.text)
  end

  it 'displays how many comments a post has' do
    expect(page).to have_content("Comments: #{@posts.first.comments_counter}")
  end

  it 'displays how many likes a post has' do
    expect(page).to have_content("Likes: #{@posts.first.likes_counter}")
  end
end
