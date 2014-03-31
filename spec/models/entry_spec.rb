require 'spec_helper'

describe Entry do

  it 'has a valid factory' do
    expect(build(:entry)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:entry, title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without a description' do
    expect(build(:entry, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without an award' do
    expect(build(:entry, award: nil)).to have(1).errors_on(:award)
  end

  it 'is invalid without a status' do
    expect(build(:entry, status: nil)).to have(1).errors_on(:status)
  end

  it 'is invalid without a content type' do
    expect(build(:entry, content_type: nil)).to have(1).errors_on(:content_type)
  end

  it 'is invalid without a user' do
    expect(build(:entry, user: nil)).to have(1).errors_on(:user)
  end

  it 'is invalid without an event' do
    expect(build(:entry, event: nil)).to have(1).errors_on(:event)
  end

  it 'is invalid with a title that is longer than the maximum title length' do
    expect(build(:entry, title: '0' * 61)).to have(1).errors_on(:title)
  end

  it 'is invalid with a description that is longer than the maximum description length' do
    expect(build(:entry, description: '0' * 301)).to have(1).errors_on(:description)
  end

  it 'is invalid without a unique title' do
    create(:entry, title: 'Unique Title')
    expect(build_stubbed(:entry, title: 'Unique Title')).to have(1).errors_on(:title)
  end
end
