FactoryBot.define do
  factory :user do
    name { 'hoge' }
    sequence(:email) { |number| "h_inoue2+test-#{number}@ga-tech.co.jp" }
    gender { :men }
    birthday { '2021-10-14' }
  end
end
