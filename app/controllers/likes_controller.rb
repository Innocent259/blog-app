class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Liked the post!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to like the post.'
    end
  end
end
