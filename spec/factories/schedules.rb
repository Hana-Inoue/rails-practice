FactoryBot.define do
  factory :schedule do
    name { 'schedule' }
    scheduled_for { DateTime.now }
    scheduled_by { 'user' }
  end
end
