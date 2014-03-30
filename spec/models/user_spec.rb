require 'spec_helper'

describe User do

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without an email' do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it 'is invalid without a valid email address' do
    expect(build(:user, email: 'test.com')).to_not be_valid
  end

  it 'is invalid without a username' do
    expect(build(:user, username: nil)).to_not be_valid
  end

  it 'is invalid with a username that is too short' do
    expect(build(:user, username: 'me')).to_not be_valid
  end

  it 'is invalid with a username that is too long' do
    expect(build(:user, username: 'meeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee')).to_not be_valid
  end

  it 'is invalid without a role' do
    expect(build(:user, role: nil)).to_not be_valid
  end

  it 'is invalid with a password that is too short' do
    expect(build(:user, password: 'pw4$')).to_not be_valid
  end

  it 'is invalid with a password that is too long' do
    expect(build(:user, password: 'passwordddddddddddddd44$')).to_not be_valid
  end

  it 'is invalid with a password that doesn\'t have the right complexity' do
    expect(build(:user, password: 'password')).to_not be_valid
  end

  context 'with a regular user role' do
    it 'is a regular user' do
      expect(build(:user).regular?).to be_true
      expect(build(:user).producer?).to be_false
      expect(build(:user).admin?).to be_false
    end
  end

  context 'with a producer role' do
    it 'is a producer' do
      expect(build(:producer).regular?).to be_false
      expect(build(:producer).producer?).to be_true
      expect(build(:producer).admin?).to be_false
    end
  end

  context 'with an admin role' do
    it 'is an admin' do
      expect(build(:admin).regular?).to be_false
      expect(build(:admin).producer?).to be_false
      expect(build(:admin).admin?).to be_true
    end
  end
end
