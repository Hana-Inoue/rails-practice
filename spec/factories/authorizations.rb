FactoryBot.define do
  factory :authorization do
    association :user

    action { 'index_action' }
  end
end
