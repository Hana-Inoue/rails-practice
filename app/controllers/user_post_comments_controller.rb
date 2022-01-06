class UserPostCommentsController < ApplicationController
  def index
    @user_post = UserPost.find(params[:user_post_id])
    @user_post_comment = @user_post.user_post_comments.build
    @user_post_comments = UserPostComment.where(user_post_id: params[:user_post_id])
  end

  def create
    @user_post = UserPost.find(params[:user_post_id])
    @user_post_comment = @user_post.user_post_comments.build(user_post_comment_params)

    if @user_post_comment.save
      redirect_to user_post_user_post_comments_path(@user_post),
                  notice: t('layouts.flash.messages.created_user_post_comment')
    else
      @user_post_comments = UserPostComment.where(user_post_id: params[:user_post_id])
      render :index
    end
  end

  def destroy
  end

  private

  def user_post_comment_params
    params.require(:user_post_comment).permit(:body).merge(commented_by: current_user.name)
  end
end
