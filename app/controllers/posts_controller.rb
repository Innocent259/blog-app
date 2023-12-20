class PostsController < ApplicationController
  def index
    @users = [User.includes(:posts).find(params[:user_id])]
    @posts = @users[0].posts.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render 'new'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def show
    @posts = [Post.find(params[:id])]
  end
end
