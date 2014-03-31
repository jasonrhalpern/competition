# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| "event#{n}" }
    description 'This event is going to be huge'
    start_date "2014-03-09"
    end_date "2014-03-10"
    close_date "2014-03-11"
    entry_fee "2.00"
    user
    approved_status
    category :music
  end
end
