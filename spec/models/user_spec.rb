require 'rails_helper'

RSpec.describe User, type: :model do
  # TODO: バリデーションを元にテスを実装
  # 現在はバリデーションを設定していないため、有効になることのみをテスト
  it '有効になる' do
    expect(build(:user)).to be_valid
  end
end
