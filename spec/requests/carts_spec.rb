require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET showページ' do
    before { session[:cart] = ['1', '5'] }

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
end
