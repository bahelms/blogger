require 'spec_helper'

describe "Static Pages" do
  subject { page }

  shared_examples 'all static pages' do
    it { should have_content(content) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home" do
    before { visit root_path }
    let(:content) { 'Sign In' }
    let(:page_title) { 'Sign In' }

    it_should_behave_like 'all static pages'

    describe "for signed-in users" do
      let(:user) { create(:user) }
      before do
        sign_in user
        visit root_path
      end

      it { should have_title(full_title(user.username)) }
      it { should have_content('Recent Blog Posts') }
    end
  end
end