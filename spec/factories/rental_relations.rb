FactoryBot.define do
  factory :rental_relation do
    lend_user { nil }
    borrow_user { nil }
    answer { "MyString" }
  end
end
