class UserAddressesController < ApplicationController
  def show
    @user = User.find_by(id: params[:user_id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
