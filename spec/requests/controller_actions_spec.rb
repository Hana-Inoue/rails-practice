require 'rails_helper'

RSpec.describe "ControllerActions", type: :request do
  before do
    create_controller_actions
    log_in(user)
  end
  let(:user) { create(:user, :admin) }
  let(:other_user) { create(:user) }

  describe 'GET editページ' do
    it '200番ステータスを返す' do
      get edit_user_controller_actions_path(other_user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH アクセス権限' do
    let(:controller_action_ids) { { controller_action_ids: ["#{ControllerAction.first.id}"] } }

    it '302番ステータスを返す' do
      patch user_controller_actions_path(other_user), params: { user: controller_action_ids }
      expect(response).to have_http_status(302)
    end

    it '任意のUserに紐づくuser_authorizationsを変更' do
      expect {
        patch user_controller_actions_path(other_user), params: { user: controller_action_ids }
      }.to change(other_user.user_authorizations, :count).by(1)
    end
  end
end
