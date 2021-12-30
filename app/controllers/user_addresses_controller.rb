class UserAddressesController < ApplicationController
  def edit
    @user = User.find_by(id: params[:user_id])
    @user_address = UserAddress.find_by(user_id: params[:user_id]) || @user.build_user_address
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @user_address = UserAddress.find_by(user_id: params[:user_id]) || @user.build_user_address

    if @user_address.update(user_address_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def user_address_params
    params
      .require(:user_address)
      .permit(:postal_code, :prefecture, :city, :address_line)
  end
end
