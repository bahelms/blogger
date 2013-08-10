namespace :db do
  desc "Fill database with sample users and articles"
  task populate: :environment do
    # Create users
    User.create!(username: "Example User",
                 email: "test@foobar.com",
                 password: "foobarfoobar",
                 password_confirmation: "foobarfoobar")
    5.times do
      User.create!(username: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: "password1234",
                   password_confirmation: "password1234")
    end
    # Create articles
    users = User.all(limit: 6)
    5.times do
      title = Faker::Lorem.sentence.capitalize
      content = Faker::Lorem.paragraphs.join
      users.each do |user| 
        user.articles.create!(title: title, content: content)
      end
    end
  end
end