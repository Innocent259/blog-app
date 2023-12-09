class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = [User.find(params[:id])]
    @posts = @users[0].recent_three_posts
  end
end
