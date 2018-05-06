FactoryBot.define do
  factory :basket do
    amount 0
    association :member
  end
end
