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

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new({
        provider: 'provider_name',
        uid: '123456',
        info: {
          name: 'John Doe',
          email: 'john@example.com'
        }
      })
    end
    
    context 'when the user does not exist' do
      it 'creates a new user' do
        expect do
          User.from_omniauth(auth)
        end.to change(User, :count).by(1)
      end

      it 'returns the newly created user' do
        user = User.from_omniauth(auth)
        expect(user).to be_a(User)
        expect(user.provider).to eq(auth.provider)
        expect(user.uid).to eq(auth.uid)
        expect(user.name).to eq(auth.info.name)
        expect(user.email).to eq(auth.info.email)
      end
    end

    context 'when the user already exists' do
      before do
        User.from_omniauth(auth)
      end

      it 'does not create a new user' do
        expect do
          User.from_omniauth(auth)
        end.not_to change(User, :count)
      end

      it 'returns the existing user' do
        user = User.from_omniauth(auth)
        expect(user).to be_a(User)
        expect(user.provider).to eq(auth.provider)
        expect(user.uid).to eq(auth.uid)
        expect(user.name).to eq(auth.info.name)
        expect(user.email).to eq(auth.info.email)
      end
    end
  end
end