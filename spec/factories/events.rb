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

  factory :upcoming_approved_event,  parent: :event do
    start_date 2.days.from_now
    end_date 5.days.from_now
    close_date 8.days.from_now
  end

  factory :current_approved_event,  parent: :event do
    current_dates
  end

  factory :current_pending_event,  parent: :event do
    current_dates
    pending_status
  end

  factory :pending_event,  parent: :event do
    pending_status
  end

  factory :rejected_event,  parent: :event do
    rejected_status
  end

  trait :current_dates do
    start_date 3.days.ago
    end_date 1.day.from_now
    close_date 2.days.from_now
  end

end
