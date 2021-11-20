class UsersController < ApplicationController
  def index
    raise NotAuthorizedError if !current_user.authorizations.find_by(action: 'index_action')

    @users = User.all
  end

  def show
    raise NotAuthorizedError if !current_user.authorizations.find_by(action: 'show_action')

    @user = User.find(params[:id])
  end

  def new
    raise NotAuthorizedError if !current_user.authorizations.find_by(action: 'new_action')

    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    if !current_user.authorizations.find_by(action: 'edit_action') && current_user.id != @user.id
      raise NotAuthorizedError
    end
  end

  def create
    raise NotAuthorizedError if !current_user.authorizations.find_by(action: 'create_action')

    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: t('layouts.flash.messages.created_user')
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if !current_user.authorizations.find_by(action: 'update_action') && current_user.id != @user.id
      raise NotAuthorizedError
    end

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])

    if !current_user.authorizations.find_by(action: 'destroy_action') && current_user.id != user.id
      raise NotAuthorizedError
    end

    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :gender, :birthday, :password, :password_confirmation)
  end
end
