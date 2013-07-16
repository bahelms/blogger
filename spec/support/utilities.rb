include ApplicationHelper

def valid_signup
  fill_in "Username",         with: "MasterShake"
  fill_in "Email",            with: "foo@foobar.com"
  fill_in "Password",         with: "foobarfoobar"
  fill_in "Confirm Password", with: "foobarfoobar"
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end
