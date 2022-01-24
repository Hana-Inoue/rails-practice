require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  before do
    create_authorizations
    log_in(user)
  end
  let(:user) { create(:user, :admin) }

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get schedules_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET showページ' do
    let(:schedule) { create(:schedule) }
    before { schedule }

    it '200番ステータスを返す' do
      get schedule_path(schedule)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get new_schedule_path
      expect(response).to have_http_status(200)
    end
  end
end
