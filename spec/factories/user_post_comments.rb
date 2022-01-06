FactoryBot.define do
  factory :user_post_comment do
    body { 'こんにちは' }
    commented_by { 'user' }
  end
end
