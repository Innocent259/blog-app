class PostsController < ApplicationController
  def index
    @users = User.includes(posts: %i[comments likes]).where(id: params[:user_id])
    @posts = @users.flat_map(&:posts)
    @comment = Comment.new
    @like = Like.new
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
