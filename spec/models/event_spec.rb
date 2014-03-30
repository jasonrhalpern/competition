require 'spec_helper'

describe Event do
  it 'has a valid factory' do
    expect(build(:event)).to be_valid
  end
end
