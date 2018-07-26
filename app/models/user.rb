class User < ActiveRecord::Base
  extend OmniAuthStruct

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def self.from_omniauth(data)
    info = auth_format(data)
    where(provider: info[:provider], uid: info[:uid]).first_or_create do |user|
      user.provider = info[:provider]
      user.uid = info[:uid]
      user.email = info[:info][:email]
      user.password = Devise.friendly_token[0,20]
    end
  end
end
