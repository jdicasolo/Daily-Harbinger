require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Sample User", 
      :email => "sample@user.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|  
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should not accept invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org sample.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create(@attr)
    user_dupe_email = User.new(@attr)
    user_dupe_email.should_not be_valid
  end

  it "should reject email up to case" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    user_dupe_email = User.create(@attr)
    user_dupe_email.should_not be_valid
  end


  describe "password validations" do

    it "should create a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

    it "should be false if the passwords don't match" do
      @user.has_password?("invalid").should be_false
    end

    it "should be true if the passwords match" do
      @user.has_password?(@attr[:password]).should be_true
    end
    
      describe "authenticate method" do

        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrong_pass")
          wrong_password_user.should be_nil
        end

        it "should return nul for an email address with no user" do
          non_existent_user = User.authenticate("unknown@user.com", @attr[:password])
          non_existent_user.should be_nil
        end

        it "should return a user on email/password match" do
          matching_user = User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @user
        end

      end

  end

  end

end
