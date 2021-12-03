class ControllerActionsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @controller_actions = ControllerAction.all
  end

  def update
  end

  private

  def controller_action_params
    params.require(:user).permit(controller_action_ids: [])
  end
end
