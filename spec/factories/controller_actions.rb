FactoryBot.define do
  factory :controller_action do
    controller { 'user' }
    action { 'index' }
  end
end
