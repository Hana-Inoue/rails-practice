require 'rails_helper'

RSpec.describe UserPostTag, type: :model do
  let(:user) { create(:user) }
  let(:tag) { create(:tag) }
  let(:user_post) { create(:user_post, user: user) }
  let(:user_post_tag) { build(:user_post_tag, user_post: user_post, tag: tag) }

  describe 'validation' do
    context '値が全て適切な場合' do
      it '有効になる' do
        expect(user_post_tag).to be_valid
      end
    end

    context 'user_post_idが空文字の場合' do
      before { user_post_tag.user_post_id = '' }
      it '無効になる' do
        expect(user_post_tag).not_to be_valid
      end
    end

    context 'tag_idが空文字の場合' do
      before { user_post_tag.tag_id = '' }
      it '無効になる' do
        expect(user_post_tag).not_to be_valid
      end
    end
  end
end
