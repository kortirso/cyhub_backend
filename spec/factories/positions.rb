FactoryBot.define do
  factory :position do
    amount 1
    association :basket
    association :product
  end
end
