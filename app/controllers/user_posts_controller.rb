class UserPostsController < ApplicationController
  def index
    @user_posts = UserPost.all
  end

  def new
    @user_post = UserPost.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
