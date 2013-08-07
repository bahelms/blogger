require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    bio 'Lorem Ipsum'
    password 'foobarfoobar'
    password_confirmation 'foobarfoobar'
  end

  factory :article do
    sequence(:title) { |n| "Article No. #{n}" }
    sequence(:content) { |n| "Article No. #{n} content" }
    user
  end
end