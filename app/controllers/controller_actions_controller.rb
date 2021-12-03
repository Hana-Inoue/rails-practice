class ControllerActionsController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @controller_actions = ControllerAction.all
  end

  def update
    @user = User.find(params[:user_id])

    # TODO: 修正
    if @user.update(controller_action_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def controller_action_params
    params.require(:user).permit(controller_action_ids: [])
  end
end
