require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    context ": password fields exist = " do
      it "both password and password_confirmation fields exist" do
        @user = User.new(email: 'e.e@e.e', password: nil)
        expect(@user.valid?).to be_falsey
        expect(@user.errors[:password]).to include("can't be blank")
      end
    end
    context ": passwords match = " do
      it "should validate password confirmation matches password" do
        @user = User.new(first_name: 'Scott', last_name: 'smith', email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        expect(@user.valid?).to be_truthy
      end
      it ": should invalidate when passwords don't match" do
      @user = User.new(first_name: 'Scott', last_name: 'smith', email: 'e.e@e.e', password: '123456', password_confirmation: '123457')
      expect(@user.valid?).to be_falsey
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
    context ": passwords must be required length = " do
      it "should validate password length" do
        @user = User.new(first_name: 'Scott', last_name: 'smith', email: 'e.e@e.e', password: '123', password_confirmation: '123')
        expect(@user.valid?).to be_falsey
        expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end
      it "should validate password with sufficient length" do
        @user = User.new(first_name: 'Scott', last_name: 'smith', email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        expect(@user.valid?).to be_truthy
      end
    end
    context ": password required for database entry = " do
      it "should require password on save" do
        @user = User.create(first_name: 'Scott', last_name: 'smith', email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        expect(@user.password_digest).not_to be_nil
      end
    end
    context ": emails must be unique = " do
      it "should validate uniqueness of email" do
        User.create(first_name: 'Scott', last_name: 'smith', email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        @user = User.new(first_name: 'Scott', email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        expect(@user.valid?).to be_falsey
        expect(@user.errors[:email]).to include('has already been taken')
      end
    end
    context ": email, first_name, and last_name are required = " do
      it "should validate presence of first_name" do
        @user = User.new(first_name: nil, last_name: 'smith', email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        expect(@user.valid?).to be_falsey
        expect(@user.errors[:first_name]).to include("can't be blank")
      end  
      it "should validate presence of last_name" do
        @user = User.new(first_name: 'Scott', last_name: nil, email: 'e.e@e.e', password: '123456', password_confirmation: '123456')
        expect(@user.valid?).to be_falsey
        expect(@user.errors[:last_name]).to include("can't be blank")
      end  
      it "should validate presence of email" do
        @user = User.new(first_name: 'Scott', last_name: 'smith', email: nil, password: '123456', password_confirmation: '123456')
        expect(@user.valid?).to be_falsey
        expect(@user.errors[:email]).to include("can't be blank")
      end  
    end
  describe".authenticate_with_credentials" do  
    before do
      # Set up a user in the database to test against
      @user = User.create(
        first_name: "Test",
        last_name: "User",
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end
    it 'returns the user if the credentials are correct' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', "password123")
      expect(authenticated_user).to eq(@user)
    end
    it 'returns nil if the email is incorrect' do
      authenticated_user = User.authenticate_with_credentials('wrong@example.com', "password123")
      expect(authenticated_user).to be_nil
    end
    it 'returns nil if the password is incorrect' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', "wrongpassword")
      expect(authenticated_user).to be_nil
    end
    it 'authenticates even with leading/trailing whitespace in the email' do
      authenticated_user = User.authenticate_with_credentials(' test@example.com ', "password123")
      expect(authenticated_user).to eq(@user)
    end
    it 'authenticates even with case differences in the email' do
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', "password123")
      expect(authenticated_user).to eq(@user)
    end
  end
  #describe "edge cases" do  
  #end 
  end
end