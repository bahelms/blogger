include ApplicationHelper

def valid_signup
  fill_in "Username",         with: "MasterShake"
  fill_in "Email",            with: "foo@foobar.com"
  fill_in "Password",         with: "foobarfoobar"
  fill_in "Confirm Password", with: "foobarfoobar"
end
