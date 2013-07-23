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
    title 'Article Title'
    content 'Lorem Ipsum'
    user
  end
end