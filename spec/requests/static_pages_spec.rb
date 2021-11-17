require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET about_server_logsページ' do
    it '200番ステータスを返す' do
      get static_pages_about_server_logs_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET about_activerecord_logsページ' do
    it '200番ステータスを返す' do
      get static_pages_about_activerecord_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
