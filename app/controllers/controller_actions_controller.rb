class ControllerActionsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @controller_actions = ControllerAction.all
  end

  def update
    @user = User.find(params[:user_id])

    if @user
      .update_user_authorizations(controller_action_params[:controller_action_ids].map(&:to_i))
      redirect_to @user, notice: t('layouts.flash.messages.change_user_authorizations.success')
    else
      flash.now[:alert] = t('layouts.flash.messages.change_user_authorizations.fail')
      render :edit
    end
  end

  private

  def controller_action_params
    params.require(:user).permit(controller_action_ids: [])
  end
end
