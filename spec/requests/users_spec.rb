require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it 'indexページの表示に成功すること' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }
    it 'showページの表示に成功すること' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end
end
