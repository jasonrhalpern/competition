require 'spec_helper'

describe Vote do

  it 'has a valid factory' do
    expect(build(:vote)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:vote, user: nil)).to_not be_valid
  end

  it 'is invalid without an entry' do
    expect(build(:vote, entry: nil)).to_not be_valid
  end

end
