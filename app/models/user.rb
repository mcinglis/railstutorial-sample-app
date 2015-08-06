
class User < ActiveRecord::Base

  validates :name, presence: true,
                   length: { maximum: 63 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  before_save { email.downcase! }

  has_secure_password
  validates :password, length: { minimum: 6 }

  attr_accessor :remember_token

  # Returns a hash digest of the given raw password.
  def User.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                : BCrypt::Engine.cost
    return BCrypt::Password.create(password, cost: cost)
  end

  # Returns a random token.
  def User.new_token()
    return SecureRandom.urlsafe_base64()
  end

  # Remembers a user in the database for use in persistent sessions.
  def set_remember_token()
    self.remember_token = User.new_token()
    update_attribute :remember_digest, User.digest(self.remember_token)
  end

  # Forgets a user.
  def forget_remember_token()
    update_attribute :remember_digest, nil
  end

  # Returns `true` if the given remember token matches the digest.
  def valid_remember_token?(token)
    if self.remember_digest.nil?
      return false
    else
      return BCrypt::Password.new(self.remember_digest).is_password?(token)
    end
  end

end

