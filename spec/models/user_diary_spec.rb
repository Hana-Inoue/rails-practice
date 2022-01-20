require 'rails_helper'

RSpec.describe UserDiary, type: :model do
  let(:user_diary) { build(:user_diary, user: user) }
  let(:user) { create(:user) }

  describe 'validation' do
    context '全ての値が適切だった場合' do
      it '有効になる' do
        expect(user_diary).to be_valid
      end
    end

    context 'titleが空文字の場合' do
      before { user_diary.title = '' }
      it '無効になる' do
        expect(user_diary).not_to be_valid
      end
    end

    context 'titleが31文字以上の場合' do
      before { user_diary.title = 'a' * 31 }
      it '無効になる' do
        expect(user_diary).not_to be_valid
      end
    end

    context 'bodyが空文字の場合' do
      before { user_diary.body = '' }
      it '無効になる' do
        expect(user_diary).not_to be_valid
      end
    end

    context 'bodyが301文字以上の場合' do
      before { user_diary.body = 'a' * 301 }
      it '無効になる' do
        expect(user_diary).not_to be_valid
      end
    end
  end
end
