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
      it '無効になる' do
        user.name = ''
        expect(user).not_to be_valid
      end
    end

    describe 'email' do
      before { user.email = email }
      let(:email) { 'h_inoue2+test-1@ga-tech.co.jp' }

      context 'emailがない場合' do
        let(:email) { '' }
        it '無効になる' do
          expect(user).not_to be_valid
        end
      end

      context 'emailが重複している場合' do
        before { create(:user, email: email) }
        it '無効になる' do
          expect(user).not_to be_valid
        end
      end

      context 'emailの大文字・小文字が異なる場合' do
        it '無効になる' do
          create(:user, email: email.upcase)
          expect(user).not_to be_valid
        end
      end
    end

    context 'genderがない場合' do
      it '無効になる' do
        user.gender = ''
        expect(user).not_to be_valid
      end
    end

    context 'birthdayがない場合' do
      it '無効になる' do
        user.birthday = ''
        expect(user).not_to be_valid
      end
    end
  end

  describe '#gender_in_japanese' do
    before { user.gender = gender }

    context 'genderがmenの場合' do
      let(:gender) { :men }
      it '男性が返される' do
        expect(user.gender_in_japanese).to eq '男性'
      end
    end

    context 'genderがwomenの場合' do
      let(:gender) { :women }
      it '女性が返される' do
        expect(user.gender_in_japanese).to eq '女性'
      end
    end

    context 'genderがothersの場合' do
      let(:gender) { :others }
      it 'その他が返される' do
        expect(user.gender_in_japanese).to eq 'その他'
      end
    end
  end
end
