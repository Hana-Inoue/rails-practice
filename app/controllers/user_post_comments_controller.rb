class UserPostCommentsController < ApplicationController
  def index
    @user_post = find_user_post
    @user_post_comment = @user_post.user_post_comments.build
    @pages, @user_post_comments =
      paginate(active_record: UserPostComment.where(user_post_id: params[:user_post_id]).order(:id))
  end

  def create
    @user_post = find_user_post
    @user_post_comment = @user_post.user_post_comments.build(user_post_comment_params)

    if @user_post_comment.save
      redirect_to(
        user_post_user_post_comments_path(@user_post),
        notice: t('layouts.flash.messages.created_user_post_comment')
      ) and return
    end
    @pages, @user_post_comments =
      paginate(
        active_record: UserPostComment.where(user_post_id: params[:user_post_id]).order(:id))
    render :index
  end

  def destroy
    UserPostComment.find(params[:id]).destroy
    redirect_to user_post_user_post_comments_path(find_user_post),
                notice: t('layouts.flash.messages.deleted_user_post_comment')
  end

  private

  def find_user_post
    UserPost.find(params[:user_post_id])
  end

  def user_post_comment_params
    params.require(:user_post_comment).permit(:body).merge(commented_by: current_user.name)
  end
end
