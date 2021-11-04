require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validation' do
    context '適切な値が全て入力された場合' do
      it '有効になる' do
        expect(user).to be_valid
      end
    end

    context 'nameがない場合' do
      before { user.name = '' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'emailがない場合' do
      before { user.email = '' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'nameが31文字以上の場合' do
      before { user.name = 'a' * 31 }
      it '無効になる' do
        p user.name
        expect(user).not_to be_valid
      end
    end

    context 'emailが重複している場合' do
      before { create(:user, email: user.email) }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'emailの大文字・小文字が異なって重複している場合' do
      before { create(:user, email: user.email.upcase) }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'emailの形式ではない文字列が入力された場合' do
      before { user.email = 'a' * 10 }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'genderがない場合' do
      before { user.gender = '' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'birthdayがない場合' do
      before { user.birthday = '' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'passwordがない場合' do
      before { user.password = '' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end
  end
end
