class UserDiariesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @pages, @user_diaries = paginate(active_record: @user.user_diaries.order(:id))
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
