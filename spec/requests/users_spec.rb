require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET showページ' do
    let(:user) { create(:user) }

    it '200番ステータスを返す' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET editページ' do
    let(:user) { create(:user) }

    it '200番ステータスを返す' do
      get edit_user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規User情報' do
    let(:user_params) { attributes_for(:user) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'showページへリダイレクトする' do
        post users_path, params: { user: user_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
      end

      it 'Userが1増える' do
        expect {
          post users_path, params: { user: user_params }
        }.to change(User, :count).by(1)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        user_params[:name] = ''
        post users_path, params: { user: user_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH User情報' do
    before { user_params[:gender] = gender }
    let(:user_params) { attributes_for(:user) }
    let!(:user) { create(:user) }

    context '有効なリクエストパラメータが渡された場合' do
      let(:gender) { :women }

      it 'showページへリダイレクトする' do
        patch user_path(user), params: { user: user_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
      end

      it '任意のUserの値を変更する' do
        expect {
          patch user_path(user), params: { user: user_params }
        }.to change { User.last[:gender] }.from('men').to('women')
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:gender) { '' }

      it '200番ステータスを返す' do
        patch user_path(user), params: { user: user_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE User情報' do
    let!(:user) { create(:user) }

    it 'indexページへリダイレクトする' do
      delete user_path(user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end

    it 'Userが1減る' do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
    end
  end
end
