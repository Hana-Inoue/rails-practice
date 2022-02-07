require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  describe 'validation' do
    context '全ての値が適切だった場合' do
      it '有効になる' do
        expect(product).to be_valid
      end
    end

    context 'nameが空文字の場合' do
      before { product.name = '' }
      it '無効になる' do
        expect(product).not_to be_valid
      end
    end

    context 'nameが31文字以上の場合' do
      before { product.name = 'a' * 31 }
      it '無効になる' do
        expect(product).not_to be_valid
      end
    end

    context 'priceが空文字の場合' do
      before { product.price = '' }
      it '無効になる' do
        expect(product).not_to be_valid
      end
    end

    context 'priceが整数でない場合' do
      before { product.price = 100.1 }
      it '無効になる' do
        expect(product).not_to be_valid
      end
    end

    context 'priceが0以下の場合' do
      before { product.price = 0 }
      it '無効になる' do
        expect(product).not_to be_valid
      end
    end
  end
end
