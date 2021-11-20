FactoryBot.define do
  factory :user do
    name { 'user' }
    sequence(:email) { |number| "h_inoue2+test-#{number}@ga-tech.co.jp" }
    gender { :men }
    birthday { '2021-10-14' }
    password { 'testtest' }
    password_confirmation { 'testtest' }

    trait :admin do
      after(:create) do |user|
        Authorization.actions.each_key do |action|
          user.authorizations << build(:authorization, action: action)
        end
      end
    end
  end
end
