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

  describe 'GET editページ' do
    let(:schedule) { create(:schedule) }
    before { schedule }

    it '200番ステータスを返す' do
      get edit_schedule_path(schedule)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET search' do
    it '200番ステータスを返す' do
      get search_schedules_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET sql_injection_search' do
    it '200番ステータスを返す' do
      get sql_injection_search_schedules_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST 新規Schedule情報' do
    let(:schedule_params) { attributes_for(:schedule) }

    context '有効なリクエストパラメータが渡された場合' do
      it 'showページへリダイレクトする' do
        post schedules_path, params: { schedule: schedule_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to schedule_path(Schedule.last)
      end

      it 'Scheduleが1増える' do
        expect {
          post schedules_path, params: { schedule: schedule_params }
        }.to change(Schedule, :count).by(1)
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      it '200番ステータスを返す' do
        schedule_params[:name] = ''
        post schedules_path, params: { schedule: schedule_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH Schedule情報' do
    let(:schedule_params) { attributes_for(:schedule) }
    let(:schedule) { create(:schedule) }
    before do
      schedule
      schedule_params[:name] = name
    end

    context '有効なリクエストパラメータが渡された場合' do
      let(:name) { 'new schedule' }

      it 'showページへリダイレクトする' do
        patch schedule_path(schedule), params: { schedule: schedule_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to schedule_path(Schedule.last)
      end

      it '任意のScheduleの値を変更する' do
        expect {
          patch schedule_path(schedule), params: { schedule: schedule_params }
        }.to change { Schedule.last[:name] }.from('schedule').to('new schedule')
      end
    end

    context '無効なリクエストパラメータが渡された場合' do
      let(:name) { '' }

      it '200番ステータスを返す' do
        patch schedule_path(schedule), params: { schedule: schedule_params }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE Schedule' do
    let(:schedule) { create(:schedule) }
    before { schedule }

    it 'indexページへリダイレクトする' do
      delete schedule_path(schedule)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to schedules_path
    end

    it 'Scheduleが1減る' do
      expect { delete schedule_path(schedule) }.to change(Schedule, :count).by(-1)
    end
  end
end
