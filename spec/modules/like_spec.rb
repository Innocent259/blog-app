require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Benjamin') }
  let(:post) { Post.create(title: 'Is Ruby The Best?', text: 'I Love Rails Framework', author_id: user.id) }
  describe '# test validations' do
    it 'should like existing post' do
      like = Like.new(user: user)
      expect(like).not_to be_valid
    end

    it 'should not like a post without a user' do
      like = Like.new
      expect(like).not_to be_valid
    end
  end

  describe '# test likes_counter' do
    it 'should update likes_counter after create' do
      expect do
        Like.create(user: user, post: post)
      end.to change { post.reload.likes_counter }.by(1)
    end
  end
end
