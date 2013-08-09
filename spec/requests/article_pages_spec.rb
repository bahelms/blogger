require 'spec_helper'

describe "Article pages" do
  subject { page }
  let(:user) { create(:user) }
  let!(:article1) { create(:article, user: user) }
  let!(:article2) { create(:article, user: user) }
  before { sign_in(user) }

  describe "index" do
    before { visit articles_path }

    it { should have_title("#{user.username} Blog Archive") }
    it { should have_content(article1.title) }
    it { should have_content(article2.title) }
  end

  describe "article creation" do
  end

  describe "view article" do
    before { visit article_path(article1) }

    # it { should have_title(article1.title) }
  end

  describe "article destruction" do
  end
end