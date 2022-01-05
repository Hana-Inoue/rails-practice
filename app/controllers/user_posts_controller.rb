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
    @user_post = current_user.user_posts.build(user_post_params)

    if @user_post.save
      redirect_to user_posts_path, notice: t('layouts.flash.messages.created_user_post')
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_post_params
    params
      .require(:user_post)
      .permit(:body)
  end
end
