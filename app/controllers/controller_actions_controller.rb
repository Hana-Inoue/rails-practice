class ControllerActionsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @controller_actions = ControllerAction.all
  end

  def update
    @user = User.find(params[:user_id])

    if update_user_authorizations
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

  def update_user_authorizations
    ActiveRecord::Base.transaction do
      delete_user_authorizations
      add_user_authorizations
    end
  rescue
    return false
  end

  def delete_user_authorizations
    @user.authorizations.destroy_all
  end

  def add_user_authorizations
    (new_controller_action_ids - old_controller_action_ids).each do |add_controller_action_id|
      ControllerAction.find_by(id: add_controller_action_id).users << @user
    end
  end

  def old_controller_action_ids
    @old_controller_action_ids ||= @user.user_authorizations.pluck(:controller_action_id)
  end

  def new_controller_action_ids
    @new_controller_action_ids ||= controller_action_params[:controller_action_ids].map(&:to_i)
  end
end
