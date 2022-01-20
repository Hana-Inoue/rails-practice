require 'rails_helper'

RSpec.describe "UserDiaries", type: :request do
  let(:user) { create(:user, :admin) }
  let(:user_diary) { create(:user_diary, user: user) }

  before do
    create_authorizations
    log_in(user)
  end

  describe "GET indexページ" do
    it '200番ステータスを返す' do
      get user_user_diaries_path(user)
      expect(response).to have_http_status(200)
    end
  end
end
