FactoryBot.define do
  factory :user do
    name { 'user' }
    sequence(:email) { |number| "h_inoue2+test-#{number}@ga-tech.co.jp" }
    gender { :men }
    birthday { '2021-10-14' }
    password { 'testtest' }
    password_confirmation { 'testtest' }

    # indexの権限のみを所有するtest userの作成
    trait :user_with_index_authorization do
      after(:create) do |user|
        user.user_authorizations <<
          build(
            :user_authorization,
            authorization_id:
              Authorization
                .find_by(
                  controller: UsersController.name.delete_suffix('Controller').underscore,
                  action: 'index')
                .id
          )
      end
    end

    # 全ての権限を所有するadmin userの作成
    trait :admin do
      after(:create) do |user|
        Authorization.all.each do |authorization|
          user.user_authorizations <<
            build(:user_authorization, authorization_id: authorization.id)
        end
      end
    end
  end
end
