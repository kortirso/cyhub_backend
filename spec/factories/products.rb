FactoryBot.define do
  factory :product do
    sequence(:name) { |i| "Product Name #{i}" }
    price 1000
  end
end
