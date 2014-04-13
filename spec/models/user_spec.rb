require 'spec_helper'

describe User do

  it 'has a valid factory' do
    expect(build_stubbed(:user)).to be_valid
  end

  it 'is invalid without an email' do
    expect(build_stubbed(:user, email: nil)).to have(2).errors_on(:email)
  end

  it 'is invalid without a valid email address' do
    expect(build_stubbed(:user, email: 'test.com')).to have(1).errors_on(:email)
  end

  it 'is invalid without a username' do
    expect(build_stubbed(:user, username: nil)).to have(2).errors_on(:username)
  end

  it 'is invalid with a username that is too short' do
    expect(build_stubbed(:user, username: '0' * 4)).to have(1).errors_on(:username)
  end

  it 'is invalid with a username that is too long' do
    expect(build_stubbed(:user, username: '0' * 31)).to have(1).errors_on(:username)
  end

  it 'is invalid without a role' do
    expect(build_stubbed(:user, role: nil)).to have(1).errors_on(:role)
  end

  it 'is invalid with a password that is too short' do
    expect(build_stubbed(:user, password: 'pw4$')).to have(1).errors_on(:password)
  end

  it 'is invalid with a password that is too long' do
    expect(build_stubbed(:user, password: 'w3#' * 7)).to have(1).errors_on(:password)
  end

  it 'is invalid with a password that doesn\'t have the right complexity' do
    expect(build_stubbed(:user, password: 'password')).to have(1).errors_on(:password)
  end

  it 'is invalid without a unique email' do
    create(:user, email: 'test@aol.com')
    expect(build_stubbed(:user, email: 'test@aol.com')).to have(1).errors_on(:email)
  end

  it 'is invalid without a unique username' do
    create(:user, username: 'TestUser')
    expect(build_stubbed(:user, username: 'TestUser')).to have(1).errors_on(:username)
  end

  context 'with a regular user role' do
    it 'is a regular user' do
      expect(build_stubbed(:user).regular?).to be_true
    end

    it 'is not a producer' do
      expect(build_stubbed(:user).producer?).to be_false
    end

    it 'is not an admin' do
      expect(build_stubbed(:user).admin?).to be_false
    end
  end

  context 'with a producer role' do
    it 'is a producer' do
      expect(build_stubbed(:producer).producer?).to be_true
    end

    it 'is not a regular user' do
      expect(build_stubbed(:producer).regular?).to be_false
    end

    it 'is not an admin' do
      expect(build_stubbed(:producer).admin?).to be_false
    end
  end

  context 'with an admin role' do
    it 'is an admin' do
      expect(build_stubbed(:admin).admin?).to be_true
    end

    it 'is not a regular user' do
      expect(build_stubbed(:admin).regular?).to be_false
    end

    it 'is not a producer' do
      expect(build_stubbed(:admin).producer?).to be_false
    end
  end
end
