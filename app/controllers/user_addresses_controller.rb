class UserAddressesController < ApplicationController
  def edit
    @user = find_user
    @user_address = @user.user_address || @user.build_user_address
  end

  def update
    @user = find_user
    @user_address = @user.user_address || @user.build_user_address

    if @user_address.update(user_address_params)
      redirect_to @user, notice: t('layouts.flash.messages.update_address.success') and return
    end
    flash.now[:alert] = t('layouts.flash.messages.update_address.fail')
    render :edit
  end

  def destroy
    user = find_user

    user.user_address.destroy
    redirect_to user, notice: t('layouts.flash.messages.deleted_address')
  end

  private

  def find_user
    User.find(params[:user_id])
  end

  def user_address_params
    params
      .require(:user_address)
      .permit(:postal_code, :prefecture, :city, :address_line)
  end
end
