class UserPostsController < ApplicationController

  def index
    @pages, @user_posts = paginate(active_record: UserPost.order(:id),
                                   previous_and_next_page_count: 2)
  end

  def new
    @user_post = UserPost.new
    @tags = tags
  end

  def edit
    @user_post = find_user_post
    @tags = tags
  end

  def create
    @user_post = current_user.user_posts.build(user_post_params)

    if @user_post.save
      redirect_to user_posts_path, notice: t('layouts.flash.messages.created_user_post') and return
    end
    @tags = tags
    render :new
  end

  def update
    @user_post = find_user_post

    if @user_post.update(user_post_params)
      redirect_to user_posts_path, notice: t('layouts.flash.messages.updated_user_post') and return
    end
    @tags = tags
    render :edit
  end

  def destroy
    find_user_post.destroy
    redirect_to user_posts_path, notice: t('layouts.flash.messages.deleted_user_post')
  end

  private

  def tags
    Tag.all
  end

  def find_user_post
    UserPost.find(params[:id])
  end

  def user_post_params
    params.require(:user_post).permit(:body, tag_ids: [])
  end
end
