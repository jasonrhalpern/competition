# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    entry nil
    user nil
    event_id 1
  end
end
