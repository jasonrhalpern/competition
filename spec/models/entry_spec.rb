require 'spec_helper'

describe Entry do

  it 'has a valid factory' do
    expect(build(:entry)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:entry, title: nil)).to_not be_valid
  end

  it 'is invalid without a description' do
    expect(build(:entry, description: nil)).to_not be_valid
  end

  it 'is invalid without an award' do
    expect(build(:entry, award: nil)).to_not be_valid
  end

  it 'is invalid without a status' do
    expect(build(:entry, status: nil)).to_not be_valid
  end

  it 'is invalid without a content type' do
    expect(build(:entry, content_type: nil)).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(build(:entry, user: nil)).to_not be_valid
  end

  it 'is invalid without an event' do
    expect(build(:entry, event: nil)).to_not be_valid
  end

  it 'is invalid with a title that is longer than the maximum title length' do
    expect(build(:entry, title: '0' * 61)).to_not be_valid
  end

  it 'is invalid with a description that is longer than the maximum description length' do
    expect(build(:entry, description: '0' * 301)).to_not be_valid
  end

  it 'is invalid without a unique title' do
    create(:entry, title: 'Unique Title')
    expect(build_stubbed(:entry, title: 'Unique Title')).to have(1).errors_on(:title)
  end
end
