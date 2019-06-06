class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name,  presence: true, length: {maximum: Settings.validateMail}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.validateName},
   format: {with: VALID_EMAIL_REGEX},
   uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
   length: {minimum: Settings.validatePassword}
  def self.digest string
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end
end
