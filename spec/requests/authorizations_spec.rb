require 'rails_helper'

RSpec.describe "Authorizations", type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET editページ' do
    it '200番ステータスを返す' do
      get edit_user_authorizations_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH アクセス権限' do
    let(:authorization_params) { { authorization_ids: new_authorization_ids } }

    context '有効なリクエストパラメータが渡された場合' do
      let(:new_authorization_ids) { [Authorization.first.id] }

      it 'user の show ページへリダイレクトする' do
        patch user_authorizations_path(user), params: { user: authorization_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user
      end

      it '任意のUserに紐づくauthorization_idsを変更' do
        expect {
          patch user_authorizations_path(user), params: { user: authorization_params }
        }.to(
          change {
            user.reload.authorization_ids
          }.from(user.authorization_ids).to(new_authorization_ids)
        )
      end
    end
  end
end
