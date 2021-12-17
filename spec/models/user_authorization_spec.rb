require 'rails_helper'

RSpec.describe UserAuthorization, type: :model do
  let(:user) { create(:user) }
  let(:authorization) { create(:authorization) }
  let(:user_authorization) do
    create(:user_authorization, user: user, authorization: authorization)
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

    context 'authorization_idが空文字の場合' do
      before { user_authorization.authorization_id = '' }
      it '無効になる' do
        expect(user_authorization).not_to be_valid
      end
    end
  end
end
