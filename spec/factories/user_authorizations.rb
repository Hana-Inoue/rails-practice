FactoryBot.define do
  factory :user_authorization do
    controller_action_id { ControllerAction.first.id }
  end
end
