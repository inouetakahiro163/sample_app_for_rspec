FactoryBot.define do
  factory :task do
    title {"タイトル"}
    content {"コンテント"}
    status {0}
    deadline {"2020-12-25 15:10:00"}
    association :user
  end
end
