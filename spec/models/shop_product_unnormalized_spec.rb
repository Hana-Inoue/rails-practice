require 'rails_helper'

RSpec.describe ShopProductUnnormalized, type: :model do
  let(:shop_product) { build(:shop_product_unnormalized) }

  describe 'validation' do
    context '全ての値が適切だった場合' do
      it '有効になる' do
        expect(shop_product).to be_valid
      end
    end

    context 'shop_nameが空文字の場合' do
      before { shop_product.shop_name = '' }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end

    context 'shop_nameが31文字以上の場合' do
      before { shop_product.shop_name = 'a' * 31 }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end

    context 'product_nameが空文字の場合' do
      before { shop_product.product_name = '' }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end

    context 'product_nameが31文字以上の場合' do
      before { shop_product.product_name = 'a' * 31 }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end

    context 'priceが空文字の場合' do
      before { shop_product.price = '' }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end

    context 'priceが整数でない場合' do
      before { shop_product.price = 100.1 }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end

    context 'priceが0以下の場合' do
      before { shop_product.price = 0 }
      it '無効になる' do
        expect(shop_product).not_to be_valid
      end
    end
  end
end
