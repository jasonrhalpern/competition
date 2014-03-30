# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    title 'This video rocks'
    description 'My video is the best'
    content_type 'mp4'
    user
    event nil
    loser_award
    approved_status
  end

  factory :winning_entry, parent: :entry do
    approved_status
    winner_award
  end

  factory :runner_up_entry, parent: :entry do
    approved_status
    runner_up_award
  end

  factory :finalist_entry, parent: :entry do
    approved_status
    finalist_award
  end

  factory :rejected_entry, parent: :entry do
    rejected_status
    loser_award
  end

  factory :pending_entry, parent: :entry do
    pending_status
    loser_award
  end


  trait :winner_award do
    award :winner
  end

  trait :runner_up_award do
    award :runner_up
  end

  trait :finalist_award do
    award :finalist
  end

  trait :loser_award do
    award :loser
  end

end
