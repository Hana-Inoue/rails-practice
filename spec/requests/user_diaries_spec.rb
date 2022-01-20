require 'rails_helper'

RSpec.describe "UserDiaries", type: :request do
  let(:user) { create(:user, :admin) }
  let(:user_diary) { create(:user_diary, user: user) }

  before do
    create_authorizations
    log_in(user)
  end

  describe "GET indexページ" do
    it '200番ステータスを返す' do
      get user_user_diaries_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get new_user_user_diary_path(user)
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
end
