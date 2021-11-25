FactoryBot.define do
  factory :user do
    name { 'user' }
    sequence(:email) { |number| "h_inoue2+test-#{number}@ga-tech.co.jp" }
    gender { :men }
    birthday { '2021-10-14' }
    password { 'testtest' }
    password_confirmation { 'testtest' }

    ['index', 'show', 'new', 'edit', 'create', 'update', 'destroy'].each do |action|
      Action.create!(controller: 'user', action: action)
    end

    # indexの権限のみを所有するtest userの作成
    trait :test_user do
      after(:create) do |user|
        user.user_authorizations <<
          build(
            :user_authorization,
            action_id: Action.find_by(controller: 'user', action: 'index').id
          )
      end
    end

    # 全ての権限を所有するadmin userの作成
    trait :admin do
      after(:create) do |user|
        Action.all.each do |action|
          user.user_authorizations << build(:user_authorization, action_id: action.id)
        end
      end
    end
  end
end
