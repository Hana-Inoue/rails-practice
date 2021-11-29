require 'rails_helper'

RSpec.describe ControllerAction, type: :model do
  let(:controller_action) { build(:controller_action) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(controller_action).to be_valid
      end
    end

    context 'controllerが空文字の場合' do
      before { controller_action.controller = '' }
      it '無効になる' do
        expect(controller_action).not_to be_valid
      end
    end

    context 'actionが空文字の場合' do
      before { controller_action.action = '' }
      it '無効になる' do
        expect(controller_action).not_to be_valid
      end
    end
  end
end
