class AuthorizationsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @authorizations = Authorization.all
  end

  def update
    @user = User.find(params[:user_id])

    begin
      @user.authorization_ids = authorization_params[:authorization_ids]
    rescue
      flash.now[:alert] = t('layouts.flash.messages.change_user_authorizations.fail')
      @authorizations = Authorization.all
      render :edit
    else
      redirect_to @user, notice: t('layouts.flash.messages.change_user_authorizations.success')
    end
  end

  private

  def authorization_params
    params.require(:user).permit(authorization_ids: [])
  end
end
