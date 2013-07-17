require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }

  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :remember_token }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }
  it { should be_valid }

  describe "validations" do
    context "when username is not present" do
      before { subject.username = nil }
      it { should_not be_valid }
    end

    context "when username is too long" do
      before { subject.username = 'a' * 41 }
      it { should_not be_valid }
    end

    context "when username is already taken" do
      before do
        same_user = subject.dup
        same_user.username.upcase!
        same_user.save
      end
      it { should_not be_valid }
    end

    context "when email is not present" do
      before { subject.email = nil }
      it { should_not be_valid }
    end

    context "when email is already taken" do
      before do
        same_email = subject.dup
        same_email.email.downcase!
        same_email.save
      end
      it { should_not be_valid }
    end

    context "when email has mixed case" do
      before do
        subject.email = 'fOObAr@BoB.CoM'
        subject.save
      end 

      it "should be saved in lowercase" do
        expect(subject.reload.email).to eq 'foobar@bob.com'
      end
    end

    context "when password is not present" do
      before { @user = build(:user, password: nil) }
      specify { expect(@user).not_to be_valid }
    end

    context "when password is too short" do
      before { subject.password = subject.password_confirmation = 'a' * 10 }
      it { should_not be_valid }
    end

    context "when password confirmation is not present" do
      before { subject.password_confirmation = nil }
      it { should_not be_valid }
    end

    context "when password confirmation doesn't match password" do
      before { subject.password_confirmation = 'mismatch' }
      it { should_not be_valid }
    end
  end

  describe "remember token" do
    before { subject.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "authenticate method" do
    before { subject.save }
    let(:found_user) { User.find_by(email: subject.email) }

    context "with valid password" do
      it { should eq found_user.authenticate(subject.password) }
    end

    context "with invalid password" do
      let(:invalid_user) { found_user.authenticate('invalid') }
      it { should_not eq invalid_user }
      specify { expect(invalid_user).to be_false }
    end
  end
end