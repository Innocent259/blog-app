require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title' do
    user = User.create(name: 'Maxwell')
    post = user.posts.build(title: 'Valid Title')
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    user = User.create(name: 'Maxwell')
    post = user.posts.build(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid with a title exceeding 250 characters' do
    user = User.create(name: 'Maxwell')
    post = user.posts.build(title: 'A' * 251)
    post.valid?
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'is valid with a non-negative integer comments_counter' do
    user = User.create(name: 'Maxwell')
    post = user.posts.build(title: 'Valid Title', comments_counter: 0)
    expect(post).to be_valid
  end

  it 'is invalid with a negative comments_counter' do
    user = User.create(name: 'Maxwell')
    post = user.posts.build(title: 'Valid Title', comments_counter: -1)
    post.valid?
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is valid with a non-negative integer likes_counter' do
    user = User.create(name: 'Maxwell')
    post = user.posts.build(title: 'Valid Title', likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is invalid with negative integer likes_counter' do
    user = User.new(name: 'Maxwell')
    post = user.posts.build(title: 'Valid title', likes_counter: -2)
    post.valid?
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  describe '#update_posts_counter' do
    it 'increments the author\'s posts_counter' do
      user = User.create(name: 'Maxwell')
      expect do
        user.posts.create(title: 'New Post')
      end.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe '#recent_comments' do
    let(:user) { User.create(name: 'Test User') }
    it 'returns the specified number of most recent comments' do
      post = user.posts.create(title: 'Test Post')
      post.comments.create(text: 'Comment 1', author: user)
      post.comments.create(text: 'Comment 2', author: user)
      comment3 = post.comments.create(text: 'Comment 3', author: user)
      comment4 = post.comments.create(text: 'Comment 4', author: user)
      comment5 = post.comments.create(text: 'Comment 5', author: user)
      comment6 = post.comments.create(text: 'Comment 6', author: user)
      comment7 = post.comments.create(text: 'Comment 7', author: user)

      recent_comments = post.recent_five_comments
      expect(recent_comments).to eq([comment7, comment6, comment5, comment4, comment3])
    end
  end
end
