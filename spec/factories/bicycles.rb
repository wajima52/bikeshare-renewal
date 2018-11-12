FactoryBot.define do
  factory :bicycle do
    name "Fenix SL 2017"
    association :user
    bicycle_type 1
  end
end
