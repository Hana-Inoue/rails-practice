require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let(:authorization) { build(:authorization) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(authorization).to be_valid
      end
    end

    context 'controllerが空文字の場合' do
      before { authorization.controller = '' }
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
