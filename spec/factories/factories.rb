FactoryGirl.define do

  trait :pending_status do
    status :pending
  end

  trait :approved_status do
    status :approved
  end

  trait :rejected_status do
    status :rejected
  end

end