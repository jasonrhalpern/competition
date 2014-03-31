require 'spec_helper'

describe Comment do

  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without a description' do
    expect(build(:comment, description: nil)).to have(1).errors_on(:description)
  end

  it 'is invalid without a user' do
    expect(build(:comment, user: nil)).to have(1).errors_on(:user)
  end

  it 'is invalid without an entry' do
    expect(build(:comment, entry: nil)).to have(1).errors_on(:entry)
  end

  it 'is invalid if the description is longer than the maximum description length' do
    expect(build(:entry, description: '0' * 401)).to have(1).errors_on(:description)
  end

  it 'is invalid if the user id is not unique within the scope of this entry' do
    comment1 = create(:comment)
    expect(build_stubbed(:comment, user_id: comment1.user_id, entry_id: comment1.entry_id)).to have(1).errors_on(:user_id)
  end

end
