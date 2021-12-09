require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    create_controller_actions
    log_in(user)
  end
  let(:user) { create(:user, :admin) }
  let(:other_user) { create(:user) }

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET showページ' do
    before { get user_path(other_user) }

    context '権限を持つユーザがアクセスした場合' do
      it '200番ステータスを返す' do
        expect(response).to have_http_status(200)
      end
    end

    context '権限を持たないユーザがアクセスしようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET newページ' do
    before { get new_user_path }

    context '権限を持つユーザがアクセスした場合' do
      it '200番ステータスを返す' do
        expect(response).to have_http_status(200)
      end
    end

    context '権限を持たないユーザがアクセスしようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET editページ' do
    before { get edit_user_path(other_user) }

    context '権限を持つユーザがアクセスした場合' do
      it '200番ステータスを返す' do
        expect(response).to have_http_status(200)
      end
    end

    context '権限を持たないユーザがアクセスしようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST 新規User情報' do
    let(:user_params) { attributes_for(:user) }

    context '権限を持つユーザによって有効なリクエストパラメータが渡された場合' do
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

    context '権限を持つユーザによって無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        user_params[:name] = ''
        post users_path, params: { user: user_params }
        expect(response).to have_http_status(200)
      end
    end

    context '権限を持たないユーザが実行しようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        post users_path, params: { user: user_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'PATCH User情報' do
    before { user_params[:gender] = gender }
    let(:user_params) { attributes_for(:user) }

    context '権限を持つユーザによって有効なリクエストパラメータが渡された場合' do
      let(:gender) { :women }

      it 'showページへリダイレクトする' do
        patch user_path(other_user), params: { user: user_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
      end

      it '任意のUserの値を変更する' do
        expect {
          patch user_path(other_user), params: { user: user_params }
        }.to change { User.last[:gender] }.from('men').to('women')
      end
    end

    context '権限を持つユーザによって無効なリクエストパラメータが渡された場合' do
      let(:gender) { '' }

      it '200番ステータスを返す' do
        patch user_path(other_user), params: { user: user_params }
        expect(response).to have_http_status(200)
      end
    end

    context '権限を持たないユーザが実行しようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }
      let(:gender) { :women }

      it 'ログインページへリダイレクトする' do
        patch user_path(other_user), params: { user: user_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE User情報' do
    context '権限を持つユーザが実行した場合' do
      before { other_user }

      it 'indexページへリダイレクトする' do
        delete user_path(other_user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end

      it 'Userが1減る' do
        expect { delete user_path(other_user) }.to change(User, :count).by(-1)
      end
    end

    context '権限を持たないユーザが実行しようとした場合' do
      let(:user) { create(:user, :user_with_index_authorization) }

      it 'ログインページへリダイレクトする' do
        delete user_path(other_user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_path
      end
    end
  end
end
