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

      describe "after submission" do
        before { click_button submit }
        it { should have_title("Sign Up") }
        it { should have_content("error") }
      end
    end

    context "with valid information" do
      before { valid_signup }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }
        let(:user) { User.find_by(email: "foo@foobar.com") }

        it { should have_title(full_title(user.username)) }
      end
    end
  end
end
