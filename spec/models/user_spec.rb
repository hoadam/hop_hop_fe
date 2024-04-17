require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:email) }
    end

    describe 'has_secure_password' do
        selena = User.new(name: 'Selena H', email: 'selena@example.com', password: 'password123', password_confirmation: 'password123')

        it 'encrypts the password' do
          expect(selena.password_digest).to be_present
          expect(selena.password_digest).not_to eq('password123')
        end

        it 'authenticates with correct password' do
          expect(selena.authenticate('password123')).to eq(selena)
        end

        it 'fails authentication with incorrect password' do
          expect(selena.authenticate('password')).to be_falsey
        end
    end
end
