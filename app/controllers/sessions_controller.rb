class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :check_authorization

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path, notice: t('sessions.flash.messages.log_in.success')
    else
      flash.now[:alert] = t('sessions.flash.messages.log_in.fail')
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path, notice: t('sessions.flash.messages.log_out')
  end
end
