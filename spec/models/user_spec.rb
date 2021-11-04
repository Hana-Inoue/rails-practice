require 'digest/sha2'
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

    context 'passwordが8文字未満の場合' do
      before { user.password = 'a' * 5 }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'password_confirmationがない場合' do
      before { user.password_confirmation = '' }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end

    context 'password_confirmationがpasswordと一致しない場合' do
      before { user.password_confirmation = 'a' * 8 }
      it '無効になる' do
        expect(user).not_to be_valid
      end
    end
  end

  describe '#valid_password?' do
    before { allow(user).to receive(:digest).and_return(password) }

    context '引数で渡された値がpasswordと一致した場合' do
      let(:password) { user.password }
      it 'trueを返す' do
        expect(user.valid_password?(password)).to eq true
      end
    end

    context '引数で渡された値がpasswordと一致しない場合' do
      let(:password) { 'invalid_password' }
      it 'falseを返す' do
        expect(user.valid_password?(password)).to eq false
      end
    end
  end

  describe '#downcase_email' do
    before { user.email = upcase_email }
    let(:upcase_email) { user.email.upcase }
    it 'emailが全て小文字になる' do
      expect(user.send(:downcase_email)).to eq upcase_email.downcase
    end
  end

  describe '#password_digest' do
    before do
      allow(user).to receive(:digest).and_return(password_digest)
      user.send(:password_digest)
    end
    let(:password_digest) { 'digested' }
    it 'passwordにdigestメソッドの返り値を代入する' do
      expect(user.password).to eq password_digest
    end
  end

  describe '#digest' do
    let(:string) { 'a' * 8 }
    it '引数に渡された値をハッシュ化した文字列を返す' do
      expect(user.send(:digest, string)).to eq Digest::SHA256.hexdigest(string)
    end
  end
end
