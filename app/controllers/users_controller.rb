class UsersController < ApplicationController
  def index
    @pages, @users = paginate(active_record: User.order(:id),
                              previous_and_next_page_count: 3,
                              max_item_count: 10)
  end

  def show
    @user = find_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = find_user
  end

  def create
    @user = User.new(user_params)

    redirect_to @user, notice: t('layouts.flash.messages.created_user') and return if @user.save
    render :new
  end

  def update
    @user = find_user

    redirect_to @user and return if @user.update(user_params)
    render :edit
  end

  def destroy
    user = find_user

    user.destroy
    redirect_to root_path, notice: t('layouts.flash.messages.deleted_user', name: user.name)
  end

  private

  def find_user
    User.find(params[:id])
  end

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :gender, :birthday, :password, :password_confirmation)
  end
end
