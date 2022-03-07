require 'rails_helper'

RSpec.describe 'UserDiaries', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get user_user_diaries_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET showページ' do
    let(:user_diary) { create(:user_diary, user: user) }

    it '200番ステータスを返す' do
      get user_user_diary_path(user, user_diary)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get new_user_user_diary_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET editページ' do
    let(:user_diary) { create(:user_diary, user: user) }

    it '200番ステータスを返す' do
      get edit_user_user_diary_path(user, user_diary)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規UserDiary' do
    let(:user_diary_params) { attributes_for(:user_diary, user: user) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'showページへリダイレクトする' do
        post user_user_diaries_path(user), params: { user_diary: user_diary_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_user_diary_path(user, UserDiary.last)
      end

      it 'UserDiaryが1増える' do
        expect {
          post user_user_diaries_path(user), params: { user_diary: user_diary_params }
        }.to change(UserDiary, :count).by(1)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        user_diary_params[:title] = ''
        post user_user_diaries_path(user), params: { user_diary: user_diary_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH UserDiary' do
    let(:user_diary) { create(:user_diary, user: user) }
    let(:user_diary_params) { attributes_for(:user_diary, user: user) }
    before { user_diary_params[:title] = title }

    context '有効なリクエストパラメータが渡された場合' do
      let(:title) { 'new title' }

      it 'showページへリダイレクトする' do
        patch user_user_diary_path(user, user_diary), params: { user_diary: user_diary_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_user_diary_path(user, user_diary)
      end

      it '任意のUserDiaryの値を変更する' do
        expect {
          patch user_user_diary_path(user, user_diary), params: { user_diary: user_diary_params }
        }.to change { user_diary.reload.title }.from(user_diary.title).to(title)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:title) { '' }

      it '200番ステータスを返す' do
        user_diary_params[:title] = ''
        patch user_user_diary_path(user, user_diary), params: { user_diary: user_diary_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE UserDiary' do
    let!(:user_diary) { create(:user_diary, user: user) }

    it 'indexページへリダイレクトする' do
      delete user_user_diary_path(user, user_diary)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_user_diaries_path(user)
    end

    it 'UserDiaryが1減る' do
      expect { delete user_user_diary_path(user, user_diary) }.to change(UserDiary, :count).by(-1)
    end
  end

  describe '他ユーザに紐づいた日記へアクセスした場合' do
    let(:other_user) { create(:user) }
    let(:other_user_diary) { create(:user_diary, user: other_user) }

    it 'セッションが切れる' do
      get user_user_diary_path(other_user, other_user_diary)
      expect(session[:user_id]).to eq nil
    end

    it 'ログインページへリダイレクトする' do
      get user_user_diary_path(other_user, other_user_diary)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_path
    end
  end
end
