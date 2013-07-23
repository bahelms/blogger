require 'spec_helper'

describe Article do
  let(:user) { create(:user) }
  let(:article) { build(:article, user: user) }
  subject { article }

  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :user_id }
  it { should respond_to :user }
  its(:user) { should eq user }
  it { should be_valid }

  describe "validations" do
    context "when title is not present" do
      before { subject.title = nil }
      it { should_not be_valid }
    end

    context "when content is not present" do
      before { subject.content = nil }
      it { should_not be_valid }
    end

    context "when user id is missing" do
      before { subject.user_id = nil }
      it { should_not be_valid }
    end
  end
end
