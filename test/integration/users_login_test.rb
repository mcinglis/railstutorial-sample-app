
require 'test_helper'


class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
  end

  test 'login with invalid credentials gives danger flash' do
    post login_path, session: { email: '', password: '' }
    assert flash.key? :danger
    get root_path
    assert flash.empty?
  end

  test 'login with valid information' do
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end

end

