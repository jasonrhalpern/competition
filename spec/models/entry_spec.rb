require 'spec_helper'

describe Entry do

  it 'has a valid factory' do
    expect(build_stubbed(:entry)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build_stubbed(:entry, title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without a description' do
    expect(build_stubbed(:entry, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without an award' do
    expect(build_stubbed(:entry, award: nil)).to have(1).errors_on(:award)
  end

  it 'is invalid without a status' do
    expect(build_stubbed(:entry, status: nil)).to have(1).errors_on(:status)
  end

  it 'is invalid without a content type' do
    expect(build_stubbed(:entry, content_type: nil)).to have(1).errors_on(:content_type)
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:entry, user: nil)).to have(1).errors_on(:user)
  end

  it 'is invalid without an event' do
    expect(build_stubbed(:entry, event: nil)).to have(1).errors_on(:event)
  end

  it 'is invalid with a title that is longer than the maximum title length' do
    expect(build_stubbed(:entry, title: '0' * 61)).to have(1).errors_on(:title)
  end

  it 'is invalid with a description that is longer than the maximum description length' do
    expect(build_stubbed(:entry, description: '0' * 301)).to have(1).errors_on(:description)
  end

  it 'is invalid without a unique title' do
    create(:entry, title: 'Unique Title')
    expect(build_stubbed(:entry, title: 'Unique Title')).to have(1).errors_on(:title)
  end

  it 'has a counter cache for votes' do
    entry = create(:entry)
    vote = build(:vote, :entry => nil).attributes
    expect { entry.votes.create(vote) }.to change { Entry.last.votes_count }.by(1)
  end

  it 'is invalid if the user id is not unique within the scope of this event' do
    entry1 = create(:entry)
    expect(build_stubbed(:entry, user_id: entry1.user_id, event_id: entry1.event_id)).to have(1).errors_on(:user_id)
  end

  it 'returns an array of approved entries' do
    entry1, entry2, entry3 = create(:entry), create(:pending_entry), create(:rejected_entry)
    expect(Entry.approved).to eq([entry1])
  end

  it 'returns an array of pending entries' do
    entry1, entry2, entry3 = create(:pending_entry), create(:pending_entry), create(:entry)
    expect(Entry.pending).to eq([entry1, entry2])
  end

  it 'returns an array of winning entries' do
    entry1, entry2, entry3 = create(:winning_entry), create(:finalist_entry), create(:winning_entry)
    expect(Entry.winners).to eq([entry1, entry3])
  end

  it 'returns an array of runner up entries' do
    entry1, entry2, entry3 = create(:finalist_entry), create(:runner_up_entry), create(:winning_entry)
    expect(Entry.runner_ups).to eq([entry2])
  end

  it 'returns an array of finalist entries' do
    entry1, entry2, entry3 = create(:finalist_entry), create(:runner_up_entry), create(:winning_entry)
    expect(Entry.finalists).to eq([entry1])
  end

  it 'has 4 comments' do
    expect(create(:entry_with_comments).comments.count).to eq(4)
  end

  it 'has 2 votes' do
    expect(create(:entry_with_votes).votes.count).to eq(2)
  end

end
