
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

  # Returns a hash digest of the given raw password.
  def User.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                : BCrypt::Engine.cost
    BCrypt::Password.create(password, cost: cost)
  end

end

