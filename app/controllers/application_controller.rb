class ApplicationController < ActionController::Base
  include SessionsHelper

  MAX_ITEM_COUNT = 20

  before_action :require_login, :check_authorization
  rescue_from NotAuthorizedError, with: :user_not_authorized

  def paginate(collection, max_item_count: MAX_ITEM_COUNT)
    [
      pages(collection, max_item_count),
      collection_per_page(collection, max_item_count)
    ]
  end

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

  def pages(collection, max_item_count)
    {
      current_page: current_page,
      last_page: last_page(collection, max_item_count)
    }
  end

  def current_page
    params[:page]&.to_i || 1
  end

  def last_page(collection, max_item_count)
    (collection.count.to_f / max_item_count).ceil
  end

  def collection_per_page(collection, max_item_count)
    collection.limit(max_item_count).offset((current_page - 1) * max_item_count)
  end
end
