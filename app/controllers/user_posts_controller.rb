class UserPostsController < ApplicationController

  def index
    @pages, @user_posts = paginate(active_record: UserPost.order(:id),
                                   previous_and_next_page_count: 2)
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
    @user_post = current_user.user_posts.build(user_post_params)

    if @user_post.save
      redirect_to user_posts_path, notice: t('user_posts.flash.messages.created')
    else
      @tags = Tag.all
      render :new
    end
  end

  def update
    @user_post = UserPost.find(params[:id])

    if @user_post.update(user_post_params)
      redirect_to user_posts_path, notice: t('user_posts.flash.messages.updated')
    else
      @tags = Tag.all
      render :edit
    end
  end

  def destroy
    UserPost.find(params[:id]).destroy
    redirect_to user_posts_path, notice: t('user_posts.flash.messages.deleted')
  end

  private

  def user_post_params
    params.require(:user_post).permit(:body, tag_ids: [])
  end
end
