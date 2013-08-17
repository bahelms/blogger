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

  describe "new article" do
    before do
      sign_in user
      visit new_user_article_path(user)
    end

    describe "page" do
      it { should have_title(full_title("Write a New Article")) }
      it { should have_content('Write a New Article') }
      it { should have_selector('label', text: 'Title') }
      it { should have_selector('label', text: 'Content') }
      it { should have_button('Publish') }
    end

    context "with invalid information" do
      it "should not create an article" do
        expect { click_button 'Publish'}.not_to change(Article, :count)
      end

      describe "after submission" do
        before { click_button 'Publish' }

        it { should have_content('error') }
        it { should have_title('Write a New Article') }
      end
    end

    context "with valid information" do
      let!(:title) { Faker::Lorem.sentence.capitalize }
      let!(:content) { Faker::Lorem.paragraphs.join }
      before { write_post(title, content) }

      it "should create a new article" do
        expect { click_button 'Publish' }.to change(Article, :count).by(1)
      end

      describe "after submission" do
        before { click_button 'Publish' }
        let(:article) { Article.find_by(title: title) }

        it { should have_title(article.title) }
        it { should have_selector('h2', text: article.title) }
        it { should have_content(published_date(article.created_at)) }
        it { should have_content(article.content) }
      end
    end
  end

  describe "show article" do
    before { visit article_path(article1) }

    it { should have_title(article1.title) }
    it { should have_content(article1.title) }
    it { should have_content(published_date(article1.created_at)) }
    it { should have_content(article1.content) }
    it { should_not have_link('Edit') }
    it { should_not have_link('Delete') }

    describe "when signed in" do
      before do
        sign_in user
        visit article_path(article1)
      end

      it { should have_link('Edit',   href: edit_article_path(article1)) }
      it { should have_link('Delete', href: article_path(article1)) }

      describe "Delete Article link" do
        it "should delete the current article" do
          expect { click_link 'Delete' }.to change(Article, :count).by(-1)
        end

        describe "redirection" do
          before do
            visit article_path(article2)
            click_link 'Delete'
          end
          
          it { should have_content("\"#{article2.title}\" was deleted.") }
        end
      end
    end
  end

  describe "edit" do
    before do
      sign_in user
      visit edit_article_path(article2)
    end

    describe "page" do
      it { should have_title(full_title("Edit \"#{article2.title}\"")) }
      it { should have_selector('h1', text: "Edit \"#{article2.title}\"") }
      it { should have_content('Title') }
      it { should have_content('Content') }
      it { should have_button('Update') }
    end

    describe "with invalid information" do
      before do
        fill_in 'Title',   with: ""
        fill_in 'Content', with: ""
        click_button 'Update'
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:title) { "A new article title" }
      let(:content) { "A new bunch of content crap." }
      before do
        write_post(title, content)
        click_button 'Update'
      end

      it { should have_title(title) }
      it { should have_content(title) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_content(published_date(article2.updated_at)) }
      it { should have_content(content) }
    end
  end
end