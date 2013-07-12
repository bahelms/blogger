require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    
    it { should have_title(full_title("Sign Up")) }
    it { should have_content("Sign Up") }
    it { should have_content("Username") }
    it { should have_content("Email") }
    it { should have_content("Password") }
    it { should have_content("Confirm Password") }
    it { should have_content("Create Account") }
  end
end
