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

    context 'emailが重複している場合' do
      before do
        create(:user, email: email)
        user.email = email
      end
      let(:email) { 'h_inoue2+test-1@ga-tech.co.jp' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'emailの大文字・小文字が異なる場合' do
      before do
        create(:user, email: email.upcase)
        user.email = email
      end
      let(:email) { 'h_inoue2+test-1@ga-tech.co.jp' }
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
