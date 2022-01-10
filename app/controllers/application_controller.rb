class ApplicationController < ActionController::Base
  include PaginationHelper
  include SessionsHelper

  before_action :require_login, :check_authorization
  rescue_from NotAuthorizedError, with: :user_not_authorized

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: t('layouts.flash.messages.require_login')
    end
  end

  def user_not_authorized
    log_out
    redirect_to login_path, alert: t('layouts.flash.messages.require_authorization')
  end

  def check_authorization
    unless current_user.authorized?(params[:controller], params[:action])
      raise NotAuthorizedError
    end
  end
end
