require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
  end
end