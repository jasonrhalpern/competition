require 'spec_helper'

describe Event do
  it 'has a valid factory' do
    expect(build_stubbed(:event)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build_stubbed(:event, title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without a description' do
    expect(build_stubbed(:event, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without a category' do
    expect(build_stubbed(:event, category: nil)).to have(1).errors_on(:category)
  end

  it 'is invalid without a status' do
    expect(build_stubbed(:event, status: nil)).to have(1).errors_on(:status)
  end

  it 'is invalid without a start date' do
    expect(build_stubbed(:event, start_date: nil)).to have(1).errors_on(:start_date)
  end

  it 'is invalid without a end date' do
    expect(build_stubbed(:event, end_date: nil)).to have(1).errors_on(:end_date)
  end

  it 'is invalid without a close date' do
    expect(build_stubbed(:event, close_date: nil)).to have(1).errors_on(:close_date)
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:event, user: nil)).to have(1).errors_on(:user)
  end

  it 'is invalid without a unique title' do
    create(:event, title: 'Unique Title')
    expect(build_stubbed(:event, title: 'Unique Title')).to have(1).errors_on(:title)
  end

  it 'is invalid with a title that is longer than the maximum title length' do
    expect(build_stubbed(:event, title: '0' * 81)).to have(1).errors_on(:title)
  end

  it 'is invalid with a description that is longer than the maximum description length' do
    expect(build_stubbed(:event, description: '0' * 601)).to have(1).errors_on(:description)
  end

  it 'is invalid if the end date comes before the start date' do
    expect(build_stubbed(:event, start_date: Date.today, end_date: Date.yesterday)).to have(1).errors_on(:start_date)
  end

  it 'is invalid if the end date is the same as the start date' do
    expect(build_stubbed(:event, start_date: Date.today, end_date: Date.today)).to have(1).errors_on(:start_date)
  end

  it 'is invalid if the close date comes before the end date' do
    expect(build_stubbed(:event, end_date: Date.today, close_date: Date.yesterday)).to have(1).errors_on(:end_date)
  end

  it 'is invalid if the close date is the same as the end date' do
    expect(build_stubbed(:event, end_date: Date.today, close_date: Date.today)).to have(1).errors_on(:end_date)
  end

  it 'has a counter cache for entries' do
    event = create(:event)
    entry = build(:entry, :event => nil).attributes
    expect { event.entries.create(entry) }.to change { Event.last.entries_count }.by(1)
  end

  it 'returns an array of approved events' do
    event1, event2, event3 = create(:event), create(:event), create(:pending_event)
    expect(Event.approved).to eq([event1, event2])
  end

  it 'returns an array of pending events' do
    event1, event2, event3 = create(:event), create(:pending_event), create(:pending_event)
    expect(Event.pending).to eq([event2, event3])
  end

  it 'returns an array of upcoming events' do
    event1, event2, event3 = create(:event), create(:upcoming_event), create(:upcoming_event)
    expect(Event.upcoming).to eq([event2, event3])
  end

  it 'returns an array of current events' do
    event1, event2 = create(:current_event), create(:upcoming_event)
    expect(Event.current).to eq([event1])
  end

  it 'returns an array of current approved events' do
    event1 = create(:current_event)
    event2 = create(:current_pending_event)
    event3 = create(:upcoming_event)
    event4 = create(:current_event, start_date: 1.week.ago)
    expect(Event.current_approved).to eq([event1, event4])
  end

  it 'returns an array of upcoming approved events' do
    event1 = create(:upcoming_event)
    event2 = create(:upcoming_rejected_event)
    event3 = create(:current_event)
    event4 = create(:upcoming_event, end_date: 1.week.from_now)
    expect(Event.upcoming_approved).to eq([event1, event4])
  end

  describe '#closed?' do
    it 'returns true if the event has closed' do
      expect(build_stubbed(:event, close_date: Date.yesterday).closed?).to be_true
    end
  end

  describe '#ended?' do
    it 'returns true if the event has ended' do
      expect(build_stubbed(:event, end_date: Date.yesterday).ended?).to be_true
    end
  end

  describe '#current?' do
    it 'returns true if the event is current' do
      expect(build_stubbed(:event, start_date: Date.yesterday, end_date: Date.tomorrow).current?).to be_true
    end
  end

  describe '#upcoming?' do
    it 'returns true if the event is upcoming' do
      expect(build_stubbed(:event, start_date: Date.tomorrow).upcoming?).to be_true
    end
  end

  context 'with an approved status' do
    let(:approved_event) { build_stubbed(:event) }

    it 'is approved' do
      expect(approved_event.approved?).to be_true
    end

    it 'is not pending' do
      expect(approved_event.pending?).to be_false
    end

    it 'is not rejected' do
      expect(approved_event.rejected?).to be_false
    end
  end

  context 'with a pending status' do
    let(:pending_event) { build_stubbed(:pending_event) }

    it 'is pending' do
      expect(pending_event.pending?).to be_true
    end

    it 'is not approved' do
      expect(pending_event.approved?).to be_false
    end

    it 'is not rejected' do
      expect(pending_event.rejected?).to be_false
    end
  end

  context 'with a rejected status' do
    let(:rejected_event) { build_stubbed(:rejected_event) }

    it 'is rejected' do
      expect(rejected_event.rejected?).to be_true
    end

    it 'is not pending' do
      expect(rejected_event.pending?).to be_false
    end

    it 'is not approved' do
      expect(rejected_event.approved?).to be_false
    end
  end

  context 'within the music category' do
    it 'is a music event' do
      expect(build_stubbed(:event, category: :music).music?).to be_true
    end
  end

  context 'within the fashion category' do
    it 'is a fashion event' do
      expect(build_stubbed(:event, category: :fashion).fashion?).to be_true
    end
  end

  context 'within the food category' do
    it 'is a food event' do
      expect(build_stubbed(:event, category: :food).food?).to be_true
    end
  end

  context 'within the dance category' do
    it 'is a dance event' do
      expect(build_stubbed(:event, category: :dance).dance?).to be_true
    end
  end

  context 'within the comedy category' do
    it 'is a comedy event' do
      expect(build_stubbed(:event, category: :comedy).comedy?).to be_true
    end
  end

  context 'within the filmmaking category' do
    it 'is a filmmaking event' do
      expect(build_stubbed(:event, category: :filmmaking).filmmaking?).to be_true
    end
  end

  context 'within the acting category' do
    it 'is an acting event' do
      expect(build_stubbed(:event, category: :acting).acting?).to be_true
    end
  end

  context 'within the writing category' do
    it 'is a writing event' do
      expect(build_stubbed(:event, category: :writing).writing?).to be_true
    end
  end

end
