class UsersController < ApplicationController
  def index
    check_authorization('index_action')

    @users = User.all
  end

  def show
    check_authorization('show_action')

    @user = User.find(params[:id])
  end

  def new
    check_authorization('new_action')

    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    check_authorization('edit_action', permit_own_user: true, target_user_id: @user.id)
  end

  def create
    check_authorization('create_action')

    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: t('layouts.flash.messages.created_user')
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    check_authorization('update_action', permit_own_user: true, target_user_id: @user.id)

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])

    check_authorization('destroy_action', permit_own_user: true, target_user_id: user.id)

    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :gender, :birthday, :password, :password_confirmation)
  end

  def check_authorization(action, permit_own_user: false, target_user_id: nil)
    unless permit_own_user
      raise NotAuthorizedError if !current_user.authorizations.find_by(action: action)
      return
    end

    if !current_user.authorizations.find_by(action: action) && current_user.id != target_user_id
      raise NotAuthorizedError
    end
  end
end
