require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:shop) { build(:shop) }

  describe 'validation' do
    context '全ての値が適切だった場合' do
      it '有効になる' do
        expect(shop).to be_valid
      end
    end

    context 'nameが空文字の場合' do
      before { shop.name = '' }
      it '無効になる' do
        expect(shop).not_to be_valid
      end
    end

    context 'nameが31文字以上の場合' do
      before { shop.name = 'a' * 31 }
      it '無効になる' do
        expect(shop).not_to be_valid
      end
    end
  end
end
