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
    @user = User.find(params[:user_id])
    @user_diary = UserDiary.find(params[:id])
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
    @user = User.find_by(id: params[:user_id])
    @user_address = @user.user_address || @user.build_user_address

    if @user_address.update(user_address_params)
      redirect_to @user, notice: t('layouts.flash.messages.update_address.success')
    else
      flash.now[:alert] = t('layouts.flash.messages.update_address.fail')
      render :edit
    end
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
