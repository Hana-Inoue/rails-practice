class UserPostsController < ApplicationController
  def index
    @user_posts = UserPost.all
  end

  def new
    @user_post = UserPost.new
    @tags = Tag.all
  end

  def edit
    @user_post = UserPost.find(params[:id])
    @tags = Tag.all
  end

  def create
    @user_post = current_user.user_posts.build(body: user_post_params[:body])

    if @user_post.save_user_post_and_tags(user_post_params[:tag_ids])
      redirect_to user_posts_path, notice: t('layouts.flash.messages.created_user_post')
    else
      @tags = Tag.all
      render :new
    end
  end

  def update
    @user_post = UserPost.find(params[:id])

    if @user_post.update_user_post_and_tags(user_post_params)
      redirect_to user_posts_path, notice: t('layouts.flash.messages.updated_user_post')
    else
      @tags = Tag.all
      render :edit
    end
  end

  def destroy
    UserPost.find(params[:id]).destroy
    redirect_to user_posts_path, notice: t('layouts.flash.messages.deleted_user_post')
  end

  private

  def user_post_params
    params.require(:user_post).permit(:body, tag_ids: [])
  end
end
