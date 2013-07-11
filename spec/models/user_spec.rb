require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }

  it { should be_valid }
  it { should respond_to :username }
  it { should respond_to :email }

  it "is invalid without a username" do
    user = build(:user, username: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end
end