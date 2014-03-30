# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:username) { |n| "person#{n}" }
    password 'abc123'
    role :regular
  end

  factory :producer, parent: :user do
    role :producer
  end

  factory :admin, parent: :user do
    role :admin
  end

end
