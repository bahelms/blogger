require 'spec_helper'

describe "Authentication" do
  let(:user) { create(:user) }
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_title('Sign In') }
    it { should have_content('Sign In') }
    it { should have_selector('label', text: 'Email') }
    it { should have_selector('label', text: 'Password') }
    it { should have_selector('input#email') }
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

      it { should have_title(full_title(user.username)) }
      it { should have_link('Sign Out',          href: signout_path) }
      it { should have_link('View Your Profile', href: user_path(user)) }
      it { should have_link('Edit Your Profile', href: edit_user_path(user)) }
      it { should have_link('Delete Account',    href: '#') }
      it { should_not have_link('Sign In',       href: signin_path) }

      describe "following signout" do
        before { click_link 'Sign Out' }

        it { should have_title(full_title('Sign In')) }
        it { should have_link('Sign In', href: signin_path) }
        it { should_not have_link('Sign Out') }
        it { should_not have_link('View Your Profile') }
        it { should_not have_link('Edit Your Profile') }
        it { should_not have_link('Delete Account') }
      end
    end
  end

  describe "authorization" do

    context "for signed out users" do

      describe "in the Users controller" do
        context "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign In') }
        end

        context "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        context "visiting the signup page" do
          before { visit signup_path }
          it { should have_title('Sign Up')}
        end

        context "visit a user's profile page" do
          before { visit user_path(user) }
          it { should have_title(user.username) }
        end
      end

      describe "when visiting a protected page" do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe "after signing in" do
          it "should display the desired page" do
            expect(page).to have_title('Edit Your Profile')
          end

          describe "after signing in again" do
            before do
              delete signout_path
              sign_in user
            end

            it "should display the user's profile page" do
              expect(page).to have_title(user.username)
            end
          end
        end
      end
    end

    context "as wrong user" do
      let(:wrong_user) { create(:user, username: "bob", 
                                       email: 'wronguser@foobar.com') }
      before { sign_in user }

      describe "visiting another user's editing page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title('Edit Your Profile') }
      end

      describe "submitting a PATCH request to another user's update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end