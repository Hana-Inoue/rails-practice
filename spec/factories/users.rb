FactoryBot.define do
  factory :user do
    name { 'hoge' }
    email { 'hoge@example.com' }
    gender { 1 }
    birthday { '2021-10-14' }
  end
end
