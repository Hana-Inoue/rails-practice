class UserAddressesController < ApplicationController
  before_action :user, only: [:edit, :update]
  before_action :user_address, only: [:edit, :update]

  def edit; end

  def update
    if @user_address.update(user_address_params)
      redirect_to @user, notice: t('layouts.flash.messages.update_address.success')
    else
      flash.now[:alert] = t('layouts.flash.messages.update_address.fail')
      render :edit
    end
  end

  def destroy
    user = find_user

    user.user_address.destroy
    redirect_to user, notice: t('layouts.flash.messages.deleted_address')
  end

  private

  def user
    @user ||= find_user
  end

  def user_address
    @user_address = @user.user_address || @user.build_user_address
  end

  def find_user
    User.find(params[:user_id])
  end

  def user_address_params
    params
      .require(:user_address)
      .permit(:postal_code, :prefecture, :city, :address_line)
  end
end
