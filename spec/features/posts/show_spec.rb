require 'rails_helper'

RSpec.describe 'posts#show', type: :feature do
  before(:each) do
    @user = User.create(name: 'Lilly', photo: 'lilly.jpg', bio: 'Software Developer', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Post 1', text: 'This is Post 1')

    5.times { |i| Comment.create(post: @post, user: @user, text: "Comment #{i + 1} for Post 1") }

    visit user_post_path(@user, @post)
  end

  it 'displays the post details' do
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.text)
    expect(page).to have_content('Comments: 5')
    expect(page).to have_content('Likes: 0')
  end

  it 'displays comments for the post' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
      expect(page).to have_content(comment.text)
    end
  end
end
