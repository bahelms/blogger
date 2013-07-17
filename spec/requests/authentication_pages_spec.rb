require 'spec_helper'

describe "Authentication" do
  let(:user) { create(:user) }
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_title('Sign In') }
    it { should have_content('Sign In') }
    it { should have_selector('label', text: 'Email') }
    it { should have_selector('input#email') }
    it { should have_selector('label', text: 'Password') }
    it { should have_selector('input#password') }
    it { should have_button('Sign In') }

    context "with invalid information" do
      before { click_button 'Sign In' }

      it { should have_error_message('Invalid email/password combination.') }

      describe "after visiting another page" do
        before { click_link 'Home' }
        it { should_not have_error_message('Invalid') }
      end
    end

    context "with valid information" do
      before { sign_in(user) }

      it { should have_title(full_title("Edit")) }
      it { should have_link('Sign Out',          href: signout_path) }
      it { should have_link('View Your Profile', href: user_path(user)) }
      it { should_not have_link('Sign In',       href: signin_path) }

      describe "following signout" do
        before { click_link 'Sign Out' }
        it { should have_link('Sign In', href: signin_path) }
      end
    end
  end
end