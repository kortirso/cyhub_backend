FactoryBot.define do
  factory :partner do
    sequence(:name) { |i| "tester#{i}" }
    label 'Label'
    description 'Description'
    link 'http://link.com'
  end
end
