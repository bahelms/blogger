require 'spec_helper'

describe "Article pages" do
  subject { page }
  let(:user) { create(:user) }
  let!(:article1) { create(:article, user: user) }
  let!(:article2) { create(:article, user: user) }

  describe "index" do
    let(:title) { "#{user.username} Blog Archives" }
    before { visit user_articles_path(user) }

    it { should have_title(title) }
    it { should have_selector('h2', text: title) }
    it { should have_content(article1.content) }
    it { should have_content(article2.content) }
    it { should have_link("#{article1.title}", href: article_path(article1)) }
  end

  describe "article creation" do
  end

  describe "view article" do
    before { visit article_path(article1) }

    it { should have_title(article1.title) }
  end

  describe "article destruction" do
  end
end