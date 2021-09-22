require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "can be validated" do 
      @user = User.new(first_name: "Issac", last_name: "Newton", email: "gravity@apple.com", password: "gravity", password_confirmation: "gravity")
      expect(@user).to be_valid
    end
    
    it "User must be created with a password" do 
      @user = User.new(first_name: "Issac", last_name: "Newton", email: "gravity@apple.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it "fails if passwords are not the same" do 
      @user = User.new(first_name: "Issac", last_name: "Newton", email: "gravity@apple.com", password: "gravity", password_confirmation: "apple")
      expect(@user).to_not be_valid
    end

    it "fails if email is left blank" do 
      @user = User.new(first_name: "Issac", last_name: "Newton", email: nil, password: "gravity", password_confirmation: "gravity")
      expect(@user).to_not be_valid
    end
    
    it "fails if first name is left blank" do 
      @user = User.new(first_name: nil, last_name: "Newton", email: "gravity@apple.com", password: "gravity", password_confirmation: "gravity")
      expect(@user).to_not be_valid
    end
    
    it "fails if last name is blank" do 
      @user = User.new(first_name: "Issac", last_name: nil, email: "gravity@apple.com", password: "gravity", password_confirmation: "gravity")
      expect(@user).to_not be_valid
    end

    it "fails if email is not unique" do 
      @user = User.new(first_name: "Issac", last_name: "Newton", email: "gravity@apple.com", password: "gravity", password_confirmation: "gravity")
      @user.save
      @user2 = User.new(first_name: "Albert", last_name: "E", email: "gravity@apple.com", password: "gravity", password_confirmation: "gravity")
      expect(@user2).to_not be_valid
    end

    it "fails if password is shorter than six characters " do 
      @user = User.new(first_name: "Issac", last_name: "Newton", email: "gravity@apple.com", password: "grav", password_confirmation: "grav")
      expect(@user).to_not be_valid
    end
  end
  
  describe '.authenticate_with_credentials' do

    it 'should pass if auth is succesful' do
      @user = User.new(first_name: "Marvin", last_name: "Gaye", email: "groove@groovy.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(User.authenticate_with_credentials('groove@groovy.com', '12345678')).to eq(@user)
    end

    it 'should fail if email is wrong' do
      @user = User.new(first_name: "Marvin", last_name: "Gaye", email: "nogroove@groovy.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(User.authenticate_with_credentials('groove@groovy.com', '12345678')).to eq(nil)
    end

    it 'should fail if password is wrong' do
      @user = User.new(first_name: "Marvin", last_name: "Gaye", email: "groove@groovy.com", password: "87654321", password_confirmation: "12345678")
      @user.save
      expect(User.authenticate_with_credentials('groove@groovy.com', '12345678')).to eq(nil)
    end

    it 'should pass with extra spaces surrounding email' do
      @user = User.new(first_name: "Marvin", last_name: "Gaye", email: "groove@groovy.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(User.authenticate_with_credentials('  groove@groovy.com   ', '12345678')).to eq(@user)
    end
    
    it 'should pass with capslock on' do
      @user = User.new(first_name: "Marvin", last_name: "Gaye", email: "groove@groovy.com", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(User.authenticate_with_credentials('GROOVE@GROOVY.com', '12345678')).to eq(@user)
    end
  end
end
