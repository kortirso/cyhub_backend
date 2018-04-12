FactoryBot.define do
  factory :member do
    name 'Member'
    description 'Description'
    association :user

    trait :active do
      active true
    end
  end
end
