require 'rails_helper'

RSpec.describe "UserPostComments", type: :request do
  let(:user) { create(:user, :admin) }
  let(:user_post) { create(:user_post, user: user) }

  before do
    create_authorizations
    log_in(user)
    user_post
  end

  describe "GET indexページ" do
    it '200番ステータスを返す' do
      get user_post_user_post_comments_path(user_post)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規UserPostComment情報' do
    let(:user_post_comment_params) { attributes_for(:user_post_comment) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'indexページへリダイレクトする' do
        post user_post_user_post_comments_path(user_post),
             params: { user_post_comment: user_post_comment_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_post_user_post_comments_path(user_post)
      end

      it 'UserPostが1増える' do
        expect {
          post user_post_user_post_comments_path(user_post),
               params: { user_post_comment: user_post_comment_params }
        }.to change(UserPostComment, :count).by(1)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        user_post_comment_params[:body] = ''
        post user_post_user_post_comments_path(user_post),
             params: { user_post_comment: user_post_comment_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE UserPostComment' do
    let(:user_post_comment) { create(:user_post_comment, user_post: user_post) }

    before { user_post_comment }

    it 'indexページへリダイレクトする' do
      delete user_post_user_post_comment_path(user_post, user_post_comment)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_post_user_post_comments_path(user_post)
    end

    it 'UserPostが1減る' do
      expect {
        delete user_post_user_post_comment_path(user_post, user_post_comment)
      }.to change(UserPostComment, :count).by(-1)
    end
  end
end
