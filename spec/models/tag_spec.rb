require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }

  describe 'validation' do
    context 'nameが適切な値だった場合' do
      it '有効になる' do
        expect(tag).to be_valid
      end
    end

    context 'nameが空文字の場合' do
      before { tag.name = '' }

      it '無効になる' do
        expect(tag).not_to be_valid
      end
    end

    context 'nameが21文字以上の場合' do
      before { tag.name = 'a' * 21 }

      it '無効になる' do
        expect(tag).not_to be_valid
      end
    end
  end
end
