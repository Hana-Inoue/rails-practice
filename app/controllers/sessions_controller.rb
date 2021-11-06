class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.registered_password_match_with?(params[:session][:password])
      log_in(user)
      redirect_to root_path, notice: t('layouts.flash.messages.notice')
    else
      flash.now[:alert] = t('layouts.flash.messages.alert')
      render :new
    end
  end
end
