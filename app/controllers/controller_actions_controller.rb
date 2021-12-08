class ControllerActionsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @controller_actions = ControllerAction.all
  end

  def update
    @user = User.find(params[:user_id])
    old_controller_action_ids = @user.user_authorizations.pluck(:controller_action_id)
    new_controller_action_ids = controller_action_params[:controller_action_ids].map(&:to_i)

    if add_user_authorizations(new_controller_action_ids - old_controller_action_ids).all? &&
        delete_user_authorizations(old_controller_action_ids - new_controller_action_ids).all?
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

  def add_user_authorizations(add_controller_action_ids)
    add_controller_action_ids.each do |add_controller_action_id|
      ControllerAction.find_by(id: add_controller_action_id).users << @user
    end
  end

  def delete_user_authorizations(delete_controller_action_ids)
    delete_controller_action_ids.each do |delete_controller_action_id|
      ControllerAction.find_by(id: delete_controller_action_id).users.delete(@user)
    end
  end
end
