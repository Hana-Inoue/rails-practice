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
        ['index', 'show', 'new', 'edit', 'create', 'update', 'destroy'].each do |action|
          Action.create!(controller: 'user', action: action)
        end
        Action.all.each do |action|
          user.user_authorizations << build(:user_authorization, action_id: action.id)
        end
      end
    end
  end
end
