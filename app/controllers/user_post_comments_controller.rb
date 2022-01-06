class UserPostCommentsController < ApplicationController
  def index
    @user_post_comments = UserPostComment.where(user_post_id: params[:user_post_id])
  end

  def create
  end

  def destroy
  end
end
