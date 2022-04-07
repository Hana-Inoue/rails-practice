class AuthorizationsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @authorizations = Authorization.all
  end

  def update
    @user = User.find(params[:user_id])

    @user.authorization_ids = authorization_params[:authorization_ids]
    redirect_to @user, notice: t('authorizations.flash.messages.change_user_authorizations.success')
  end

  private

  def authorization_params
    params.require(:user).permit(authorization_ids: [])
  end
end
