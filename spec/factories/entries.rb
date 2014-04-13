# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    sequence(:title) { |n| "This entry rocks#{n}" }
    description 'My video is the best'
    content_type 'mp4'
    user
    event
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

  factory :entry_with_comments, parent: :entry do
    ignore do
      comments_count 4
    end

    after(:create) do |entry, evaluator|
      create_list(:comment, evaluator.comments_count, entry: entry)
    end
  end

  factory :entry_with_votes, parent: :entry do
    ignore do
      votes_count 2
    end

    after(:create) do |entry, evaluator|
      create_list(:vote, evaluator.votes_count, entry: entry)
    end
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
