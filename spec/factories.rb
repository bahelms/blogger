require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    password "foobar"
    password_confirmation "foobar"
  end
end