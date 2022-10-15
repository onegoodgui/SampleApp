require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params:{ user:{ name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}}


    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select "div#error_explanation"
    assert_select "div.alert-danger"
  end

  test "valid signup information" do
    assert_difference 'User.count' do
      post users_path, params:{user:{name: "L. Lawliet", email:"l@deathnote.com", password: "Kiraisshit", password_confirmation: "Kiraisshit"}}

    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
