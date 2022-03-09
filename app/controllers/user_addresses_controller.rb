class UserAddressesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @user_address = @user.user_address || @user.build_user_address
  end

  def update
    @user = User.find(params[:user_id])
    @user_address = @user.user_address || @user.build_user_address

    if @user_address.update(user_address_params)
      redirect_to @user, notice: t('user_addresses.flash.messages.updated') and return
    end
    render :edit
  end

  def destroy
    user = User.find(params[:user_id])

    user.user_address.destroy
    redirect_to user, notice: t('user_addresses.flash.messages.deleted')
  end

  private

  def user_address_params
    params
      .require(:user_address)
      .permit(:postal_code, :prefecture, :city, :address_line)
  end
end
