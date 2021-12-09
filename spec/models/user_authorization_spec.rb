require 'rails_helper'

RSpec.describe UserAuthorization, type: :model do
  let(:user) { create(:user) }
  let(:controller_action) { create(:controller_action) }
  let(:user_authorization) do
    create(:user_authorization, user: user, controller_action: controller_action)
  end

  describe 'validation' do
    context '値が全て適切な場合' do
      it '有効になる' do
        expect(user_authorization).to be_valid
      end
    end

    context 'user_idが空文字の場合' do
      before { user_authorization.user_id = '' }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end

    context 'user_idがusersテーブルのidカラムに存在しない値の場合' do
      before { user_authorization.user_id = User.last.id + 1 }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end

    context 'controller_action_idが空文字の場合' do
      before { user_authorization.controller_action_id = '' }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end

    context 'controller_action_idがcontroller_actionsテーブルのidカラムに存在しない値の場合' do
      before { user_authorization.controller_action_id = ControllerAction.last.id + 1 }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end
  end
end
