require 'spec_helper'

describe Event do
  it 'has a valid factory' do
    expect(build(:event)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:event, title: nil)).to_not be_valid
  end

  it 'is invalid without a description' do
    expect(build(:event, description: nil)).to_not be_valid
  end

  it 'is invalid without a category' do
    expect(build(:event, category: nil)).to_not be_valid
  end

  it 'is invalid without a status' do
    expect(build(:event, status: nil)).to_not be_valid
  end

  it 'is invalid without a start date' do
    expect(build(:event, start_date: nil)).to_not be_valid
  end

  it 'is invalid without a end date' do
    expect(build(:event, end_date: nil)).to_not be_valid
  end

  it 'is invalid without a close date' do
    expect(build(:event, close_date: nil)).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(build(:event, user: nil)).to_not be_valid
  end

  it 'is invalid without a unique title' do
    create(:event, title: 'Unique Title')
    expect(build_stubbed(:event, title: 'Unique Title')).to have(1).errors_on(:title)
  end

  it 'is invalid with a title that is longer than the maximum title length' do
    expect(build(:event, title: '0' * 81)).to_not be_valid
  end

  it 'is invalid with a description that is longer than the maximum description length' do
    expect(build(:event, description: '0' * 601)).to_not be_valid
  end

  it 'is invalid if the end date is less than or equal to the start date' do
    expect(build(:event, start_date: Date.today, end_date: Date.today)).to_not be_valid
    expect(build(:event, start_date: Date.today, end_date: Date.yesterday)).to_not be_valid
  end

  it 'is invalid if the close date is less than or equal to the end date' do
    expect(build(:event, end_date: Date.today, close_date: Date.today)).to_not be_valid
    expect(build(:event, end_date: Date.today, close_date: Date.yesterday)).to_not be_valid
  end

end
