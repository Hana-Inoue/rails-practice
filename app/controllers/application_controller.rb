class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :require_login

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: t('layouts.flash.messages.require_login')
    end
  end
end
