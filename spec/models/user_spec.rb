require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }

  it { should be_valid }
  it { should respond_to :username }
  it { should respond_to :email }

  describe "validations" do
    context "when username is not present" do
      before { subject.username = nil }
      it { should_not be_valid }
    end

    context "when username is too long" do
      before { subject.username = 'a' * 41 }
      it { should_not be_valid }
    end

    context "when email is not present" do
      before { subject.email = nil }
      it { should_not be_valid }
    end

    context "when password is not present" do
      before {  }
    end
  end
end