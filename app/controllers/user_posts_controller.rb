class UserPostsController < ApplicationController
  def index
    @user_posts = UserPost.all
  end

  def new
    @user_post = UserPost.new
  end

  def edit
    @user_post = UserPost.find(params[:id])
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
    @user_post = UserPost.find(params[:id])

    if @user_post.update(user_post_params)
      redirect_to user_posts_path, notice: t('layouts.flash.messages.updated_user_post')
    else
      render :edit
    end
  end

  def destroy
    UserPost.find(params[:id]).destroy
    redirect_to user_posts_path, notice: t('layouts.flash.messages.deleted_user_post')
  end

  private

  def user_post_params
    params
      .require(:user_post)
      .permit(:body)
  end
end
