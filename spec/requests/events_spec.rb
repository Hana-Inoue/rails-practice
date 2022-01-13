require 'rails_helper'

RSpec.describe "Events", type: :request do
  before do
    create_authorizations
    log_in(user)
  end
  let(:user) { create(:user, :admin) }

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get events_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET showページ' do
    let(:event) { create(:event) }
    before { event }

    it '200番ステータスを返す' do
      get event_path(event)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET newページ' do
    it '200番ステータスを返す' do
      get new_event_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET editページ' do
    let(:event) { create(:event) }
    before { event }

    it '200番ステータスを返す' do
      get edit_event_path(event)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規Event情報' do
    let(:event_params) { attributes_for(:event) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'showページへリダイレクトする' do
        post events_path, params: { event: event_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to event_path(Event.last)
      end

      it 'Eventが1増える' do
        expect {
          post events_path, params: { event: event_params }
        }.to change(Event, :count).by(1)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        event_params[:title] = ''
        post events_path, params: { event: event_params }
        expect(response).to have_http_status(200)
      end
    end
  end
end
