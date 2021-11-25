require 'rails_helper'

RSpec.describe UserAuthorization, type: :model do
  let(:user) { create(:user) }
  let(:action) { create(:action) }
  let(:user_authorization) { create(:user_authorization, user: user, action: action) }

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

    context 'action_idが空文字の場合' do
      before { user_authorization.action_id = '' }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end

    context 'action_idがactionsテーブルのidカラムに存在しない値の場合' do
      before { user_authorization.action_id = Action.last.id + 1 }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end
  end
end
