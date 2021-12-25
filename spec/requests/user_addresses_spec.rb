require 'rails_helper'

RSpec.describe "UserAddresses", type: :request do
  before do
    create_authorizations
    log_in(user)
  end
  let(:user) { create(:user, :admin) }

  describe 'GET editページ' do
    it '200番ステータスを返す' do
      get edit_user_user_address_path(user)
      expect(response).to have_http_status(200)
    end
  end
end
