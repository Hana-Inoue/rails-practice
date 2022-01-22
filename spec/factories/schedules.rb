FactoryBot.define do
  factory :schedule do
    name { 'schedule' }
    scheduled_for { DateTime.now }
  end
end
