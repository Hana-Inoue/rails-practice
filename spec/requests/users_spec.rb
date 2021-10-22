require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it '200番ステータスが返される' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users" do
    let(:user_params) { attributes_for(:user) }
    context '適切なデータが渡された場合' do
      it 'showページへリダイレクトされる' do
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

    context '不適切なデータが渡された場合' do
      it '200番ステータスが返される' do
        user_params[:name] = ''
        post users_path, params: { user: user_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /users/:id" do
    let(:user) { create(:user) }
    it '200番ステータスが返される' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/new" do
    it '200番ステータスが返される' do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end
end
