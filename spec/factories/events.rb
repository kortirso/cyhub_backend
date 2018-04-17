FactoryBot.define do
  factory :event do
    sequence(:name) { |i| "event#{i}" }
    description 'Description'
    link 'Link'
  end
end
