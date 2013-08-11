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
    let!(:article1) { create(:article, user: user) }
    let!(:article2) { create(:article, user: user) }
    before { visit user_path(user) }

    it { should have_title(full_title(user.username)) }
    it { should have_selector('h1', text: user.username) }
    it { should have_content('Bio') }

    describe "articles feed" do
      it { should have_content(article1.content) }
      it { should have_content(article2.content) }
      it { should have_selector('h2', text: 'Recent Blog Posts') }
      it { should have_link("Archives", href: user_articles_path(user)) }
    end
  end

  describe "edit" do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_title(full_title('Edit Your Profile')) }
      it { should have_selector('h1',    text: 'Edit Your Profile') }
      it { should have_selector('label', text: 'Username') }
      it { should have_selector('label', text: 'Email') }
      it { should have_selector('label', text: 'Bio') }
      it { should have_selector('label', text: 'Password') }
      it { should have_selector('label', text: 'Confirm Password') }
      it { should have_selector('input#user_username') }
      it { should have_selector('input#user_email') }
      it { should have_selector('textarea#user_bio') }
      it { should have_selector('input#user_password') }
      it { should have_selector('input#user_password_confirmation') }
      it { should have_button('Update') }
      it { should have_link('Delete Account', href: user_path(user)) }
    end

    describe "with invalid information" do
      before { click_button 'Update' }

      it { should have_content('error') }
    end

    describe "with valid information" do
      before do
        fill_in 'Username',         with: 'New Name'
        fill_in 'Email',            with: 'NewEmail@foobar.com'
        fill_in 'Bio',              with: 'New Lorem Ipsum'
        fill_in 'Password',         with: user.password
        fill_in 'Confirm Password', with: user.password
        click_button 'Update'
      end

      it { should have_title(full_title('New Name')) }
      it { should have_selector('h1', text: 'New Name') }
      it { should have_content('newemail@foobar.com') }
      it { should have_content('New Lorem Ipsum') }
      specify { expect(user.reload.username).to eq 'New Name' }
      specify { expect(user.reload.email).to eq 'newemail@foobar.com' }
    end

    describe "Delete Account link" do
      it "should delete the current user's account" do
        expect { click_link 'Delete Account' }.to change(User, :count).by(-1)
      end

      describe "redirection" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
