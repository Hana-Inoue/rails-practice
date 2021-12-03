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
    before do
      create_controller_actions
      log_in(user)
    end
    let(:user) { create(:user, :user_with_index_authorization) }

    it 'ログインページへリダイレクトする' do
      get user_path(user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_path
    end
  end
end
