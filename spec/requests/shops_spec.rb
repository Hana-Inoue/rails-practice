require 'rails_helper'

RSpec.describe 'Shops', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get shops_path
      expect(response).to have_http_status(200)
    end
  end
end
