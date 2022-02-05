require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET showページ' do
    it '200番ステータスを返す' do
      get cart_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 商品を買い物かごに追加' do
    let(:params) { { product_id: product.id } }
    let(:product) { create(:product) }

    it '商品一覧ページへリダイレクトする' do
      post cart_path, params: params
      expect(response).to have_http_status(302)
      expect(response).to redirect_to products_path
    end
  end

  describe 'DELETE 商品を買い物かごから削除' do
    let(:params) { { product_id: product.id } }
    let(:product) { create(:product) }
    before do
      allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session)
        .and_return({ user_id: user.id, cart: ["#{product.id}", '5'] })
    end

    it '商品一覧ページへリダイレクトする' do
      delete cart_path, params: params
      expect(response).to have_http_status(302)
      expect(response).to redirect_to cart_path
    end
  end
end
