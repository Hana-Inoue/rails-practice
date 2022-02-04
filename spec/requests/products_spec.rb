require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get products_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 商品を買い物かごに追加' do
    let(:product) { create(:product) }

    it '商品一覧ページへリダイレクトする' do
      post add_product_to_cart_product_path(product)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to products_path
    end
  end
end
