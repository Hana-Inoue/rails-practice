class UserAddressesController < ApplicationController
  def edit
    @user = User.find_by(id: params[:user_id])
    @user_address = UserAddress.find_by(user_id: params[:user_id]) || @user.build_user_address
  end

  def update
  end

  def destroy
  end
end
