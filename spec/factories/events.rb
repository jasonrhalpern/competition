# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyText"
    start_date "2014-03-09"
    end_date "2014-03-09"
    entry_fee "9.99"
    user nil
    category nil
  end
end
