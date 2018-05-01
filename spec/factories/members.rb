FactoryBot.define do
  factory :member do
    name 'Member'
    title 'Title'
    association :user

    trait :active do
      active true
    end
  end
end
