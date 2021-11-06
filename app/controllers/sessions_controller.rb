class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.registered_password_match_with?(params[:session][:password])
      # TODO: trueだった(ログインに成功した)場合の挙動を実装
    else
      flash.now[:alert] = t('sessions.new.flash.alert')
      render :new
    end
  end
end
