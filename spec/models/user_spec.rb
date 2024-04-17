require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations are now being handled by devise
  # name is null: false now in db
  # Validations interfere with updating existing users (If user does not want to change password, he can leave field blank in form)
    describe 'validations' do 
        it { should validate_presence_of(:name) }
    #     it { should validate_presence_of(:email) }
    #     it { should validate_presence_of(:password) }
    #     it { should validate_presence_of(:password_confirmation) }
    end

    describe 'has_secure_password' do
        selena = User.new(name: 'Selena H', email: 'selena@example.com', password: 'password123', password_confirmation: 'password123')
        
        it 'encrypts the password' do
          expect(selena.save).to eq(true)
          expect(selena.encrypted_password).to be_present
        end
    
        it 'authenticates with correct password' do
          expect(selena.valid_password?('password123')).to be_truthy
        end
    
        it 'fails authentication with incorrect password' do
          expect(selena.valid_password?('password')).to be_falsey
        end
    end
end