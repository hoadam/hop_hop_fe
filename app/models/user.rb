class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
          :recoverable, 
          :rememberable, 
          :validatable,
          :omniauthable, omniauth_providers: [:google_oauth2]

# Now Devise is handling authorization and checking for presence of email password and password confirmation

  validates :name, presence: true
  # validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates_presence_of :password
  # validates_presence_of :password_confirmation

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
    end
  end
end
