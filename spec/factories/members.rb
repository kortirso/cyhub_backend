FactoryBot.define do
  factory :member do
    name 'Member'
    description 'Description'
    association :user
  end
end
