require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { build(:event) }

  describe 'validation' do
    context '全てが適切な値だった場合' do
      it '有効になる' do
        expect(event).to be_valid
      end
    end

    context 'titleが空文字の場合' do
      before { event.title = '' }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'titleが31文字以上の場合' do
      before { event.title = 'a' * 31 }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'bodyが空文字の場合' do
      before { event.body = '' }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'bodyが141文字以上の場合' do
      before { event.body = 'a' * 141 }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'max_participantsが空文字の場合' do
      before { event.max_participants = '' }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'start_atが空文字の場合' do
      before { event.start_at = '' }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'finish_atが空文字の場合' do
      before { event.finish_at = '' }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'start_atがfinish_atよりも未来の場合' do
      before { event.start_at = event.finish_at + 1 }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'hostが空文字の場合' do
      before { event.host = '' }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end

    context 'hostが31文字以上の場合' do
      before { event.host = 'a' * 31 }
      it '無効になる' do
        expect(event).not_to be_valid
      end
    end
  end
end
