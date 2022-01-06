require 'rails_helper'

RSpec.describe "UserPostComments", type: :request do
  before do
    create_authorizations
    log_in(user)
    user_post
  end
  let(:user) { create(:user, :admin) }
  let(:user_post) { create(:user_post, user: user) }


  describe "GET indexページ" do
    it '200番ステータスを返す' do
      get user_post_user_post_comments_path(user_post)
      expect(response).to have_http_status(200)
    end
  end
end
