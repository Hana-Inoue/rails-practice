require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) { create(:user, :admin) }
  before do
    create_authorizations
    log_in(user)
  end

  describe 'GET indexページ' do
    it '200番ステータスを返す' do
      get events_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET showページ' do
    let(:event) { create(:event) }

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

    it '200番ステータスを返す' do
      get edit_event_path(event)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET search' do
    let(:events_search_params) { { title: 'aaa', min_max_participants: '1' } }

    it '200番ステータスを返す' do
      get search_events_path, params: { search: events_search_params }
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

  describe 'PATCH Event情報' do
    let(:event) { create(:event) }
    let(:event_params) { attributes_for(:event) }
    before { event_params[:title] = title }

    context '有効なリクエストパラメータが渡された場合' do
      let(:title) { 'event2' }

      it 'showページへリダイレクトする' do
        patch event_path(event), params: { event: event_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to event
      end

      it '任意のEventの値を変更する' do
        expect {
          patch event_path(event), params: { event: event_params }
        }.to change { event.reload.title }.from(event.title).to(title)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:title) { '' }

      it '200番ステータスを返す' do
        patch event_path(event), params: { event: event_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE Event情報' do
    let!(:event) { create(:event) }

    it 'indexページへリダイレクトする' do
      delete event_path(event)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to events_path
    end

    it 'Eventが1減る' do
      expect { delete event_path(event) }.to change(Event, :count).by(-1)
    end
  end
end
