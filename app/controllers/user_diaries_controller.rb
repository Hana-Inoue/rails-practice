class UserDiariesController < ApplicationController
  before_action :check_access_right_with_user_id
  before_action :check_access_right_with_user_diary_id, only: [:show, :edit, :update, :destroy]

  def index
    @user = find_user
    @pages, @user_diaries = paginate(active_record: @user.user_diaries.order(:id))
  end

  def show
    @user = find_user
    @user_diary = UserDiary.find(params[:id])
  end

  def new
    @user = find_user
    @user_diary = @user.user_diaries.build
  end

  def edit
    @user = find_user
    @user_diary = UserDiary.find(params[:id])
  end

  def create
    @user = find_user
    @user_diary = @user.user_diaries.build(user_diary_params)

    if @user_diary.save
      redirect_to user_user_diary_path(@user, @user_diary),
                  notice: t('layouts.flash.messages.created_user_diary')
    else
      render :new
    end
  end

  def update
    @user = find_user
    @user_diary = UserDiary.find(params[:id])

    if @user_diary.update(user_diary_params)
      redirect_to user_user_diary_path(@user, @user_diary),
                  notice: t('layouts.flash.messages.updated_user_diary')
    else
      render :edit
    end
  end

  def destroy
    user_diary = UserDiary.find(params[:id])

    user_diary.destroy
    redirect_to user_user_diaries_path(find_user),
                notice: t('layouts.flash.messages.deleted_user_diary', title: user_diary.title)
  end

  private

  def check_access_right_with_user_id
    raise NotAuthorizedError unless current_user.id == params[:user_id].to_i
  end

  def check_access_right_with_user_diary_id
    raise NotAuthorizedError unless current_user.id == UserDiary.find(params[:id]).user_id
  end

  def find_user
    User.find(params[:user_id])
  end

  def user_diary_params
    params
      .require(:user_diary)
      .permit(:title, :body)
  end
end
