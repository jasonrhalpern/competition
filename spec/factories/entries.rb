# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    title "MyString"
    description "MyText"
    content_type "MyString"
    user nil
    event nil
  end
end
