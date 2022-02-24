class UserPostsController < ApplicationController
  before_action :user_post, only: [:edit, :update]
  before_action :tags, only: [:new, :edit]

  def index
    @pages, @user_posts = paginate(active_record: UserPost.order(:id),
                                   previous_and_next_page_count: 2)
  end

  def new
    @user_post = UserPost.new
  end

  def edit; end

  def create
    @user_post = current_user.user_posts.build(user_post_params)

    if @user_post.save
      redirect_to user_posts_path, notice: t('layouts.flash.messages.created_user_post')
    else
      tags
      render :new
    end
  end

  def update
    if @user_post.update(user_post_params)
      redirect_to user_posts_path, notice: t('layouts.flash.messages.updated_user_post')
    else
      tags
      render :edit
    end
  end

  def destroy
    find_user_post.destroy
    redirect_to user_posts_path, notice: t('layouts.flash.messages.deleted_user_post')
  end

  private

  def tags
    @tags ||= Tag.all
  end

  def user_post
    @user_post ||= find_user_post
  end

  def find_user_post
    UserPost.find(params[:id])
  end

  def user_post_params
    params.require(:user_post).permit(:body, tag_ids: [])
  end
end
