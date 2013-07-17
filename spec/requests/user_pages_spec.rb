require 'spec_helper'

describe "User Pages" do
  let(:user) { create(:user) }
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

        it { should have_link('Sign Out') }
        it { should have_title(full_title(user.username)) }
        it { should have_success_message('Welcome to Blogger!') }
      end
    end
  end

  describe "profile page" do
    before { visit user_path(user) }

    it { should have_title(full_title(user.username)) }
    it { should have_selector('h1', text: user.username) }
    it { should have_selector('h2', text: 'Recent Blog Posts') }
  end

  describe "edit" do
    before do
      visit signin_path
      sign_in user
      visit edit_user_path(user)
    end

    it { should have_title(full_title("Edit Your Profile")) }
  end
end
