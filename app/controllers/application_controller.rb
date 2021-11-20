class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :require_login
  rescue_from NotAuthorizedError, with: :user_not_authorized

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: t('layouts.flash.messages.require_login')
    end
  end

  def user_not_authorized
    redirect_back(
      fallback_location: root_path,
      alert: t('layouts.flash.messages.require_authorization')
    )
  end
end
