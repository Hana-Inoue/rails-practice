class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.registered_password_match_with?(params[:session][:password])
      log_in(user)
      redirect_to root_path, notice: t('layouts.flash.messages.log_in.success')
    else
      flash.now[:alert] = t('layouts.flash.messages.log_in.fail')
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path, notice: t('layouts.flash.messages.log_out')
  end
end
