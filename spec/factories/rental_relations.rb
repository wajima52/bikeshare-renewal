FactoryBot.define do
  factory :rental_relation do
    association :bicycle
    association :borrow_user, factory: :user
    answer 0
  end
end
