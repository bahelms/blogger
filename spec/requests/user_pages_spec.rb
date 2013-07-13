require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create Account" }
    
    it { should have_title(full_title("Sign Up")) }
    it { should have_content("Sign Up") }
    it { should have_content("Username") }
    it { should have_content("Email") }
    it { should have_content("Password") }
    it { should have_content("Confirm Password") }
    it { should have_button("Create Account") }

    context "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  end
end
