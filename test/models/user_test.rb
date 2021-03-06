
require 'test_helper'


class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar')
  end

  test 'should be valid with name and email' do
    assert @user.valid?
  end

  test 'should be invalid without name' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'should be invalid without email' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'should be invalid with name too long' do
    @user.name = 'a' * 100
    assert_not @user.valid?
  end

  test 'should be invalid with email too long' do
    @user.email = ('a' * 300) + '@example.com'
    assert_not @user.valid?
  end

  test 'should be valid with valid email addresses' do
    valid = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
               first.last@foo.jp alice+bob@baz.cn]
    valid.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid = %w[user@example,com user_at_foo.org user.name@example.
                 foo@bar_baz.com foo@bar+baz.com foo@baz..com]
    invalid.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be unique and case-insensitive' do
    duplicate_user = @user.dup
    duplicate_user.email.upcase!
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@eXaMple.COM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'should be invalid with password too short' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'remember token should be invalid whenever remember digest is nil' do
    assert_not @user.valid_remember_token? ''
  end

end

