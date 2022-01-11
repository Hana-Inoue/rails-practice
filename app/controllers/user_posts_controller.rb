class UserPostsController < ApplicationController
  MAX_ITEM_COUNT = 20

  def index
    @current_page = params[:page]&.to_i || 1
    @last_page = (UserPost.count.to_f / MAX_ITEM_COUNT).ceil
    @user_posts = UserPost
                    .order(:id)
                    .limit(MAX_ITEM_COUNT)
                    .offset((@current_page - 1) * MAX_ITEM_COUNT)
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
    @user_post = current_user.user_posts.new(user_post_params)

    if @user_post.save
      redirect_to user_posts_path, notice: t('layouts.flash.messages.created_user_post')
    else
      @tags = Tag.all
      render :new
    end
  end

  def update
    @user_post = UserPost.find(params[:id])

    if @user_post.update(user_post_params)
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
