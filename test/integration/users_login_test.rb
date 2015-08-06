
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

  test 'login with valid credentials should log the user in' do
    log_in_as @user
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'logout after login should log the user out' do
    log_in_as @user
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end

  test 'logout twice should not prompt an error' do
    log_in_as @user
    delete logout_path
    delete logout_path
  end

  test 'login with remembering should set remember token in cookies' do
    log_in_as @user, remember_me: '1'
    assert is_logged_in?
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test 'login without remembering should not set remember token in cookies' do
    log_in_as @user, remember_me: '0'
    assert is_logged_in?
    assert_nil cookies['remember_token']
  end

end

