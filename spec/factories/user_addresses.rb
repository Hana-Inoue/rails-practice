FactoryBot.define do
  factory :user_address do
    postal_code { '000-0000' }
    prefecture { '東京都' }
    city { '渋谷区' }
    address_line { '道玄坂1' }
  end
end
