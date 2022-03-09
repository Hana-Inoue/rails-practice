class AuthorizationsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @authorizations = Authorization.all
  end

  def update
    @user = User.find(params[:user_id])

    if @user.update_user_authorizations(authorization_params[:authorization_ids])
      redirect_to @user, notice: t('layouts.flash.messages.change_user_authorizations.success')
    else
      flash.now[:alert] = t('layouts.flash.messages.change_user_authorizations.fail')
      render :edit
    end
  end

  private

  def authorization_params
    params.require(:user).permit(authorization_ids: [])
  end
end
