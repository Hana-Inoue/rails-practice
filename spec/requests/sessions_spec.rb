require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST ログイン情報' do
    let(:user) { create(:user) }
    let(:params) { { session: { email: email, password: password } } }

    context '有効なリクエストパラメータが渡された場合' do
      let(:email) { user.email }
      let(:password) { attributes_for(:user)[:password] }

      it 'rootページへリダイレクトする' do
        post login_path, params: params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:email) { user.email }
      let(:password) { 'invalid_password' }

      it '200番ステータスを返す' do
        post login_path, params: params
        expect(response).to have_http_status(200)
      end
    end
  end
end
