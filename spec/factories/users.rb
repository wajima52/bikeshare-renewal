FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "hanako#{n}"}
    sequence(:email){ |n| "hanako#{n}@aa.com"}
    password "hanako87"
  end
end
