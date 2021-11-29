require 'rails_helper'

RSpec.describe 'Application', type: :request do
  describe '#require_login' do
    it 'ログインされていない場合にログインページへリダイレクトする' do
      get static_pages_about_server_logs_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_path
    end
  end

  describe '#user_not_authorized' do
    before { post login_path, params: params }
    let(:params) { { session: { email: email, password: password } } }
    let(:email) { user.email }
    let(:password) { attributes_for(:user)[:password] }
    let(:user) { create(:user, :user_with_index_authorization) }

    it 'リダイレクトされる' do
      get user_path(user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end
end
