class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.registered_password_match_with?(params[:session][:password])
      # TODO: trueだった(ログインに成功した)場合の挙動を実装
    else
      # TODO: エラーメッセージの表示
      render :new
    end
  end
end
