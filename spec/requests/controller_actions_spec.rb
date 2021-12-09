require 'rails_helper'

RSpec.describe "ControllerActions", type: :request do
  before do
    create_controller_actions
    log_in(user)
  end
  let(:user) { create(:user, :admin) }
  let(:other_user) { create(:user) }

  describe 'GET editページ' do
    before { get edit_user_controller_actions_path(other_user) }

    context '権限を持つユーザがアクセスした場合' do
      it '200番ステータスを返す' do
        expect(response).to have_http_status(200)
      end
    end

    context '権限を持たないユーザがアクセスしようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'PATCH アクセス権限' do
    before do
      patch user_controller_actions_path(other_user), params: { user: controller_action_ids }
    end
    let(:controller_action_ids) { { controller_action_ids: ["#{ControllerAction.first.id}"] } }

    context '権限を持つユーザがアクセス権限の変更に成功した場合' do
      it '302番ステータスを返す' do
        expect(response).to have_http_status(302)
      end
    end

    context '権限を持たないユーザがアクセスしようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end
end
