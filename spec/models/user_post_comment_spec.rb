require 'rails_helper'

RSpec.describe UserPostComment, type: :model do
  let(:user_post_comment) do
    build(:user_post_comment, user_post: user_post, commented_by: user.name)
  end
  let(:user_post) { create(:user_post, user: user) }
  let(:user) { create(:user) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(user_post_comment).to be_valid
      end
    end

    context 'bodyが空文字の場合' do
      before { user_post_comment.body = '' }
      it '無効になる' do
        expect(user_post_comment).not_to be_valid
      end
    end

    context 'bodyが141文字以上の場合' do
      before { user_post_comment.body = 'a' * 141 }
      it '無効になる' do
        expect(user_post_comment).not_to be_valid
      end
    end

    context 'commented_byが空文字の場合' do
      before { user_post_comment.commented_by = '' }
      it '無効になる' do
        expect(user_post_comment).not_to be_valid
      end
    end

    context 'commented_byが31文字以上の場合' do
      before { user_post_comment.commented_by = 'a' * 31 }
      it '無効になる' do
        expect(user_post_comment).not_to be_valid
      end
    end
  end
end
