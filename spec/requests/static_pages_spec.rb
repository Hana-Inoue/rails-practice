require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET about_logsページ' do
    it '200番ステータスを返す' do
      get static_pages_about_logs_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET about_activerecordページ' do
    it '200番ステータスを返す' do
      get static_pages_about_activerecord_path
      expect(response).to have_http_status(200)
    end
  end
end
