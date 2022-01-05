require 'rails_helper'

RSpec.describe "UserPosts", type: :request do
  before do
    create_authorizations
    log_in(user)
  end
  let(:user) { create(:user, :admin) }
  let(:user_post) { create(:user_post, user: user) }


  describe "GET indexページ" do
    it '200番ステータスを返す' do
      get user_posts_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get new_user_post_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET editページ' do
    it '200番ステータスを返す' do
      get edit_user_post_path(user_post)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規UserPost情報' do
    let(:user_post_params) { attributes_for(:user_post) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'showページへリダイレクトする' do
        post user_posts_path, params: { user_post: user_post_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_posts_path
      end

      it 'UserPostが1増える' do
        expect {
          post user_posts_path, params: { user_post: user_post_params }
        }.to change(UserPost, :count).by(1)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        user_post_params[:body] = ''
        post user_posts_path, params: { user_post: user_post_params }
        expect(response).to have_http_status(200)
      end
    end
  end
end
