require 'rails_helper'

RSpec.describe User, type: :model do
  context '適切な値が全て入力された場合' do
    let(:user) { build(:user) }
    it '有効になる' do
      expect(user).to be_valid
    end
  end

  context 'nameがない場合' do
    let(:user_without_name) { build(:user, name: '') }
    it '無効になる' do
      expect(user_without_name).not_to be_valid
    end
  end

  context 'emailがない場合' do
    let(:user_without_email) { build(:user, email: '') }
    it '無効になる' do
      expect(user_without_email).not_to be_valid
    end
  end
end
