FactoryBot.define do
  factory :user_authorization do
    authorization_id { Authorization.first.id }
  end
end
