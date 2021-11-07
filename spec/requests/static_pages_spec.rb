require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  before { post login_path, params: params }
  let(:params) { { session: { email: email, password: password } } }
  let(:email) { user.email }
  let(:user) { create(:user) }
  let(:password) { attributes_for(:user)[:password] }

  describe 'GET about_rails_logsページ' do
    it '200番ステータスを返す' do
      get static_pages_about_rails_logs_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET about_activerecord_logsページ' do
    it '200番ステータスを返す' do
      get static_pages_about_activerecord_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
