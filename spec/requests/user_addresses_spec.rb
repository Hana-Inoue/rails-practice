require 'rails_helper'

RSpec.describe 'UserAddresses', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET editページ' do
    it '200番ステータスを返す' do
      get edit_user_user_address_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH 住所情報' do
    let!(:user_address) { create(:user_address, user: user) }
    let(:user_address_params) { attributes_for(:user_address) }
    before { user_address_params[:postal_code] = postal_code }

    context '有効なリクエストパラメータが渡された場合' do
      let(:postal_code) { '111-1111' }

      it 'uesr showページへリダイレクトする' do
        patch user_user_address_path(user), params: { user_address: user_address_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user
      end

      it '任意のUserAddressの値を変更する' do
        expect {
          patch user_user_address_path(user), params: { user_address: user_address_params }
        }.to change { user_address.reload.postal_code }
          .from(user_address.postal_code)
          .to(postal_code)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:postal_code) { '1111111' }

      it '200番ステータスを返す' do
        patch user_user_address_path(user), params: { user_address: user_address_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE 住所情報' do
    before { create(:user_address, user: user) }

    it 'user showページへリダイレクトする' do
      delete user_user_address_path(user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user
    end

    it '住所情報が1つ減る' do
      expect { delete user_user_address_path(user) }.to change(UserAddress, :count).by(-1)
    end
  end
end
