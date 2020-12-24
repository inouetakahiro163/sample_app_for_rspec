FactoryBot.define do
  factory :user do
    sequence(:email){ |n| "user_#{n}@example.com" }
    password {"maria163"}
    password_confirmation {"maria163"}
  end
end
