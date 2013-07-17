include ApplicationHelper

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def valid_signup
  fill_in "Username",         with: "MasterShake"
  fill_in "Email",            with: "foo@foobar.com"
  fill_in "Password",         with: "foobarfoobar"
  fill_in "Confirm Password", with: "foobarfoobar"
end

def sign_in(user)
  fill_in "email",    with: user.email
  fill_in "password", with: user.password
  click_button "Sign In"
end