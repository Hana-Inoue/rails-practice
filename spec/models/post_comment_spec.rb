require 'rails_helper'

RSpec.describe PostComment, type: :model do
  let(:post_comment) { build(:post_comment, user_post: user_post, user: user) }
  let(:user_post) { create(:user_post, user: user) }
  let(:user) { create(:user) }

  describe 'validation' do
    context 'bodyが適切な値だった場合' do
      it '有効になる' do
        expect(post_comment).to be_valid
      end
    end

    context 'bodyが空文字の場合' do
      before { post_comment.body = '' }
      it '無効になる' do
        expect(post_comment).not_to be_valid
      end
    end

    context 'bodyが141文字以上の場合' do
      before { post_comment.body = 'a' * 141 }
      it '無効になる' do
        expect(post_comment).not_to be_valid
      end
    end
  end
end
