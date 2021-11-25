class UsersController < ApplicationController
  def index
    check_authorization

    @users = User.all
  end

  def show
    check_authorization

    @user = User.find(params[:id])
  end

  def new
    check_authorization

    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    check_authorization(authorize_self_resource: true, resource_owner_id: @user.id)
  end

  def create
    check_authorization

    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: t('layouts.flash.messages.created_user')
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    check_authorization(authorize_self_resource: true, resource_owner_id: @user.id)

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])

    check_authorization(authorize_self_resource: true, resource_owner_id: user.id)

    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :gender, :birthday, :password, :password_confirmation)
  end

  def check_authorization(authorize_self_resource: false, resource_owner_id: nil)
    if authorize_self_resource
      unless current_user.authorized?(params[:action]) ||
             current_user.id == resource_owner_id
        raise NotAuthorizedError
      end
    else
      raise NotAuthorizedError unless current_user.authorized?(params[:action])
    end
  end
end
