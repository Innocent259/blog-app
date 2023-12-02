require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name' do
    user = User.new(name: 'Maxwell Innocent')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is valid with a non-negative integer posts_counter' do
    user = User.new(name: 'Maxwell Innocent', posts_counter: 0)
    expect(user).to be_valid
  end

  describe '#recent_three_posts' do
    it 'returns the three most recent posts' do
      user = User.create(name: 'Alice')
      older_post = user.posts.create(title: 'Older Post', created_at: 2.days.ago)
      newest_post = user.posts.create(title: 'Newest Post', created_at: Time.now)
      middle_post = user.posts.create(title: 'Middle Post', created_at: 1.day.ago)
      user.posts.create(title: 'Middle Post', created_at: 3.day.ago)
      user.posts.create(title: 'Middle Post', created_at: 4.day.ago)

      recent_posts = user.recent_three_posts

      expect(recent_posts).to eq([newest_post, middle_post, older_post])
    end
  end
end
