class User < ApplicationRecord
  devise :two_factor_authenticatable

  devise :registerable,
          :recoverable, 
          :rememberable, 
          :validatable,
          :omniauthable, omniauth_providers: [:google_oauth2]

# Now Devise is handling authorization and checking for presence of email password and password confirmation

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
    end
  end
end
