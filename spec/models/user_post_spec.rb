require 'rails_helper'

RSpec.describe UserPost, type: :model do
  let(:user_post) { build(:user_post, user: user) }
  let(:user) { create(:user) }

  describe 'validation' do
    context 'bodyが適切な値だった場合' do
      it '有効になる' do
        expect(user_post).to be_valid
      end
    end

    context 'bodyが空文字の場合' do
      before { user_post.body = '' }
      it '無効になる' do
        expect(user_post).not_to be_valid
      end
    end

    context 'bodyが141文字以上の場合' do
      before { user_post.body = 'a' * 141 }
      it '無効になる' do
        expect(user_post).not_to be_valid
      end
    end
  end
end
