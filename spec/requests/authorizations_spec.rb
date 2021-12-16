require 'rails_helper'

RSpec.describe "Authorizations", type: :request do
  before do
    create_authorizations
    log_in(user)
  end
  let(:user) { create(:user, :admin) }
  let(:other_user) { create(:user) }

  describe 'GET editページ' do
    it '200番ステータスを返す' do
      get edit_user_authorizations_path(other_user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH アクセス権限' do
    let(:authorization_ids) { { authorization_ids: ["#{Authorization.first.id}"] } }

    it '302番ステータスを返す' do
      patch user_authorizations_path(other_user), params: { user: authorization_ids }
      expect(response).to have_http_status(302)
    end

    it '任意のUserに紐づくuser_authorizationsを変更' do
      expect {
        patch user_authorizations_path(other_user), params: { user: authorization_ids }
      }.to change(other_user.user_authorizations, :count).by(1)
    end
  end
end
