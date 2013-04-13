require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "invalid with empty attributes" do
    user = User.new
    assert !user.valid?
    assert user.errors[:name].include?("can't be blank")
    assert user.errors[:login].include?("can't be blank")
    assert user.errors[:email].include?("can't be blank")
    assert user.errors[:password].include?("can't be blank")
  end
  
  test "should raise an exception if the email address doesn't validate" do
    user = User.new(:name=>'newuser', :login=>'newlogin', :email=>'newuser@bad@com**',:password=>'newuser',:password_confirmation=>'newuser')
    assert !user.save
    assert user.errors[:email].include?("is invalid")
  end

  test "should create a user on submitting a valid email" do
    @user = User.new(:name=>'newuser', :login=>'newlogin',:password=>'newuser',:password_confirmation=>'newuser')
    begin
      @user.email = 'newuser@yahoo.com'
      User.count == 1
    rescue
      User.count == 0
    end
  end
  
  test "should not create a user on submitting an invalid email" do
    @user = User.new(:name=>'newuser', :login=>'newlogin',:password=>'newuser',:password_confirmation=>'newuser')
    begin
      @user.email = 'newuser@bad@com**'
      User.count == 1
    rescue
      User.count == 0
    end
  end
  
  test 'should not create a user when password confirmation does not match with password' do
    @user = User.new
    @user.password = 'newuser'
    @user.password_confirmation = 'newuser1'
    assert !@user.save
    assert @user.errors[:password].include?("doesn't match confirmation")
  end

  test "should not signin user with invalid username" do
    username = "testuser123"
    password = "testuser"
    begin
      @user = User.authenticate(username,password)
      true
    rescue
    end
  end
  
  test "should not signin user with invalid password" do
    username = "testuser"
    password = "testuser123"
    begin
      @user = User.authenticate(username,password)
      true
    rescue
    end
  end
  
  test "should encrypt the password upon registering" do
    @user = User.new(:name => 'testuser', :email => 'testuser@yahoo.com', :password => 'testuser', :password_confirmation => 'testuser')
    begin
      @user.password = "$wr34asxaf4g5678dfthtergrtw"
      User.count == 1
    rescue
      User.count == 0
    end
  end  
end
