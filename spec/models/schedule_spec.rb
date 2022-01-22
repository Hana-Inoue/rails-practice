require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:schedule) { build(:schedule) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(schedule).to be_valid
      end
    end

    context 'nameが空文字の場合' do
      before { schedule.name = '' }
      it '無効になる' do
        expect(schedule).not_to be_valid
      end
    end

    context 'nameが31文字以上の場合' do
      before { schedule.name = 'a' * 31 }
      it '無効になる' do
        expect(schedule).not_to be_valid
      end
    end

    context 'scheduled_forが空文字の場合' do
      before { schedule.scheduled_for = '' }
      it '無効になる' do
        expect(schedule).not_to be_valid
      end
    end

    context 'scheduled_byが空文字の場合' do
      before { schedule.scheduled_by = '' }
      it '無効になる' do
        expect(schedule).not_to be_valid
      end
    end

    context 'scheduled_byが31文字以上の場合' do
      before { schedule.scheduled_by = 'a' * 31 }
      it '無効になる' do
        expect(schedule).not_to be_valid
      end
    end
  end
end
