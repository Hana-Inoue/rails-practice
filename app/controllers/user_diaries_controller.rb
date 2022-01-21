class UserDiariesController < ApplicationController
  before_action :check_access_right_with_user_id
  before_action :check_access_right_with_user_diary_id, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @pages, @user_diaries = paginate(active_record: @user.user_diaries.order(:id))
  end

  def show
    @user = User.find(params[:user_id])
    @user_diary = UserDiary.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @user_diary = @user.user_diaries.build
  end

  def edit
  end

  def create
    @user = User.find(params[:user_id])
    @user_diary = @user.user_diaries.build(user_diary_params)

    if @user_diary.save
      redirect_to user_user_diary_path(@user, @user_diary),
                  notice: t('layouts.flash.messages.created_user_diary')
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def check_access_right_with_user_id
    raise NotAuthorizedError unless current_user.id == params[:user_id].to_i
  end

  def check_access_right_with_user_diary_id
    raise NotAuthorizedError unless current_user.id == UserDiary.find(params[:id]).user_id
  end

  def user_diary_params
    params
      .require(:user_diary)
      .permit(:title, :body)
  end
end
