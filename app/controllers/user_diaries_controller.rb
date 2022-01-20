class UserDiariesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @pages, @user_diaries = paginate(active_record: @user.user_diaries.order(:id))

    @user_diaries.each { |user_diary| check_authorization_for(user_diary) }
  end

  def show
    @user = User.find(params[:user_id])
    @user_diary = UserDiary.find(params[:id])

    check_authorization_for(@user_diary)
  end

  def new
    @user = User.find(params[:user_id])
    @user_diary = @user.user_diaries.build

    check_authorization_for(@user_diary)
  end

  def edit
  end

  def create
    @user = User.find(params[:user_id])
    @user_diary = @user.user_diaries.build(user_diary_params)

    check_authorization_for(@user_diary)

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

  def check_authorization_for(user_diary)
    raise NotAuthorizedError unless current_user.id == user_diary.user_id
  end

  def user_diary_params
    params
      .require(:user_diary)
      .permit(:title, :body)
  end
end
