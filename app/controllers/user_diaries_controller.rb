class UserDiariesController < ApplicationController
  before_action :check_access_user

  def index
    @user = User.find(params[:user_id])
    @pages, @user_diaries = paginate(active_record: @user.user_diaries.order(:id))
  end

  def show
  end

  def new
    @user = User.find(params[:user_id])
    @user_diary = @user.user_diaries.build
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def check_access_user
    raise NotAuthorizedError unless current_user.id == params[:user_id].to_i
  end
end
