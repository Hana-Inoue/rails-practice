require 'rails_helper'

RSpec.describe Action, type: :model do
  let(:action) { build(:action) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(action).to be_valid
      end
    end

    context 'controllerが空文字の場合' do
      before { action.controller = '' }
      it '無効になる' do
        expect(action).not_to be_valid
      end
    end

    context 'actionが空文字の場合' do
      before { action.action = '' }
      it '無効になる' do
        expect(action).not_to be_valid
      end
    end
  end
end
