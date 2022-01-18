FactoryBot.define do
  factory :event do
    title { 'event' }
    body { 'This event is...' }
    max_participants { 10 }
    start_at { DateTime.now + 7 }
    finish_at { DateTime.now + 7 + Rational('1/24') }
    host { 'user' }
  end
end
