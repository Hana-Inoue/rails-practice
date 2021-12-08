class ControllerActionsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @controller_actions = ControllerAction.all
  end

  def update
    @user = User.find(params[:user_id])
    former_controller_action_ids = @user.user_authorizations.pluck(:controller_action_id)

    (controller_action_params[:controller_action_ids].map(&:to_i) - former_controller_action_ids).each do |controller_action_id|
      ControllerAction.find_by(id: controller_action_id).users << @user
    end
    (former_controller_action_ids - controller_action_params[:controller_action_ids].map(&:to_i)).each do |controller_action_id|
      ControllerAction.find_by(id: controller_action_id).users.delete(@user)
    end

    # TODO: 修正
    #if @user.update(controller_action_params)
    #  redirect_to @user
    #else
    #  render :edit
    #end
  end

  private

  def controller_action_params
    params.require(:user).permit(controller_action_ids: [])
  end
end
