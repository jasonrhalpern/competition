require 'spec_helper'

describe Vote do

  it 'has a valid factory' do
    expect(build_stubbed(:vote)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build_stubbed(:vote, user: nil)).to have(1).errors_on(:user)
  end

  it 'is invalid without an entry' do
    expect(build_stubbed(:vote, entry: nil)).to have(1).errors_on(:entry)
  end
end
