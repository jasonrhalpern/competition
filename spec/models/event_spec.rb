require 'spec_helper'

describe Event do
  it 'has a valid factory' do
    expect(build(:event)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:event, title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without a description' do
    expect(build(:event, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without a category' do
    expect(build(:event, category: nil)).to have(1).errors_on(:category)
  end

  it 'is invalid without a status' do
    expect(build(:event, status: nil)).to have(1).errors_on(:status)
  end

  it 'is invalid without a start date' do
    expect(build(:event, start_date: nil)).to have(1).errors_on(:start_date)
  end

  it 'is invalid without a end date' do
    expect(build(:event, end_date: nil)).to have(1).errors_on(:end_date)
  end

  it 'is invalid without a close date' do
    expect(build(:event, close_date: nil)).to have(1).errors_on(:close_date)
  end

  it 'is invalid without a user' do
    expect(build(:event, user: nil)).to have(1).errors_on(:user)
  end

  it 'is invalid without a unique title' do
    create(:event, title: 'Unique Title')
    expect(build_stubbed(:event, title: 'Unique Title')).to have(1).errors_on(:title)
  end

  it 'is invalid with a title that is longer than the maximum title length' do
    expect(build(:event, title: '0' * 81)).to have(1).errors_on(:title)
  end

  it 'is invalid with a description that is longer than the maximum description length' do
    expect(build(:event, description: '0' * 601)).to have(1).errors_on(:description)
  end

  it 'is invalid if the end date is less than or equal to the start date' do
    expect(build(:event, start_date: Date.today, end_date: Date.today)).to have(1).errors_on(:start_date)
    expect(build(:event, start_date: Date.today, end_date: Date.yesterday)).to have(1).errors_on(:start_date)
  end

  it 'is invalid if the close date is less than or equal to the end date' do
    expect(build(:event, end_date: Date.today, close_date: Date.today)).to have(1).errors_on(:end_date)
    expect(build(:event, end_date: Date.today, close_date: Date.yesterday)).to have(1).errors_on(:end_date)
  end

  describe 'scopes' do

    it 'returns an array of approved events' do
      event1, event2, event3 = create(:event), create(:event), create(:pending_event)
      expect(Event.approved).to eq([event1, event2])
    end

    it 'returns an array of pending events' do
      event1, event2, event3 = create(:event), create(:pending_event), create(:pending_event)
      expect(Event.pending).to eq([event2, event3])
    end

    it 'returns an array of upcoming events' do
      event1, event2, event3 = create(:event), create(:upcoming_approved_event), create(:upcoming_approved_event)
      expect(Event.upcoming).to eq([event2, event3])
    end

    it 'returns an array of current and approved events' do
      event1 = create(:current_approved_event)
      event2 = create(:current_pending_event)
      event3 = create(:upcoming_approved_event)
      event4 = create(:current_approved_event, start_date: 1.week.ago)
      expect(Event.current_approved).to eq([event1, event4])
    end

    it 'returns an array of upcoming and approved events' do
      event1 = create(:upcoming_approved_event)
      event2 = create(:current_pending_event)
      event3 = create(:current_approved_event)
      event4 = create(:upcoming_approved_event, end_date: 1.week.from_now)
      event5 = create(:rejected_event)
      expect(Event.upcoming_approved).to eq([event1, event4])
    end

  end

end
