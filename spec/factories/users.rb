FactoryGirl.define do
    factory :user do
        sequence(:email) { |i| "tester#{i}@gmail.com" }
        password 'password'
        role 'user'

        trait :admin do
            role 'admin'
        end
    end
end
