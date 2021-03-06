require 'rails_helper'

RSpec.describe "UserPosts", type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

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
    let(:user_post) { create(:user_post, user: user) }

    it '200番ステータスを返す' do
      get edit_user_post_path(user_post)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規UserPost情報' do
    let(:user_post_params) { attributes_for(:user_post, tag_ids: [create(:tag).id]) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'indexページへリダイレクトする' do
        post user_posts_path, params: { user_post: user_post_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_posts_path
      end

      it 'UserPostが1増える' do
        expect {
          post user_posts_path, params: { user_post: user_post_params }
        }.to change(UserPost, :count).by(1)
      end

      it 'UserPostTagが1増える' do
        expect {
          post user_posts_path, params: { user_post: user_post_params }
        }.to change(UserPostTag, :count).by(1)
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

  describe 'PATCH UserPost情報' do
    let(:user_post) { create(:user_post, user: user) }
    let(:user_post_params) { attributes_for(:user_post) }
    before { user_post_params[:body] = body }

    context '有効なリクエストパラメータが渡された場合' do
      let(:body) { 'aaa' }

      it 'indexページへリダイレクトする' do
        patch user_post_path(user_post), params: { user_post: user_post_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_posts_path
      end

      it '任意のUserPostの値を変更する' do
        expect {
          patch user_post_path(user_post), params: { user_post: user_post_params }
        }.to change { user_post.reload.body }.from(user_post.body).to(body)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:body) { '' }

      it '200番ステータスを返す' do
        patch user_post_path(user_post), params: { user_post: user_post_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE UserPost' do
    let!(:user_post) { create(:user_post, user: user, tag_ids: [create(:tag).id]) }

    it 'indexページへリダイレクトする' do
      delete user_post_path(user_post)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_posts_path
    end

    it 'UserPostが1減る' do
      expect { delete user_post_path(user_post) }.to change(UserPost, :count).by(-1)
    end

    it 'UserPostTagが1減る' do
      expect { delete user_post_path(user_post) }.to change(UserPostTag, :count).by(-1)
    end
  end
end
