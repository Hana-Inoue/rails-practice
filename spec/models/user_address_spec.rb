require 'rails_helper'

RSpec.describe UserAddress, type: :model do
  let(:user_address) { create(:user_address, user: user) }
  let(:user) { create(:user) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(user_address).to be_valid
      end
    end

    context 'postal_codeが空文字の場合' do
      before { user_address.postal_code = '' }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'prefectureが空文字の場合' do
      before { user_address.prefecture = '' }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'cityが空文字の場合' do
      before { user_address.city = '' }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'address_lineが空文字の場合' do
      before { user_address.address_line = '' }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'postal_codeが指定の形式でない場合' do
      before { user_address.postal_code = '0' * 7 }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'prefectureが21文字以上の場合' do
      before { user_address.prefecture = 'a' * 21 }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'cityが51文字以上の場合' do
      before { user_address.city = 'a' * 51 }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end

    context 'address_lineが201文字以上の場合' do
      before { user_address.address_line = 'a' * 201 }
      it '無効になる' do
        expect(user_address).not_to be_valid
      end
    end
  end
end
