require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let(:user) { create(:user) }
  let(:authorization) { create(:authorization, user: user) }

  describe 'validation' do
    context '値が全て適切な場合' do
      it '有効になる' do
        expect(authorization).to be_valid
      end
    end

    context 'user_idが空文字の場合' do
      before { authorization.user_id = '' }
      it '無効になる' do
        expect(authorization).not_to be_valid
      end
    end

    context 'user_idがusersテーブルのidカラムに存在しない値の場合' do
      before { authorization.user_id = User.last.id + 1 }
      it '無効になる' do
        expect(authorization).not_to be_valid
      end
    end

    context 'actionが空文字の場合' do
      before { authorization.action = '' }
      it '無効になる' do
        expect(authorization).not_to be_valid
      end
    end
  end
end
