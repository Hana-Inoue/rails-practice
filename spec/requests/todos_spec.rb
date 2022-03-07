require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get todos_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET search' do
    it '200番ステータスを返す' do
      get search_todos_path
      expect(response).to have_http_status(200)
    end
  end
end
