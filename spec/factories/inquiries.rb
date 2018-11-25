FactoryBot.define do
  factory :inquiry do
    title 'タイトル'
    sequence(:email) { |n| "inquiry#{n}@example.com" }
    message 'メッセージ'
  end
end
