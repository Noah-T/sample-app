class User < ActiveRecord::Base
  attr_accessor :remember_token

  
	#force email to save as all lowercase 
	before_save { email.downcase! }
	#name must be present
	validates :name, presence: true, length: { maximum: 50}
	#capital letters indicate constant
	  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

 	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }

    has_secure_password
    #allow user to not include password when updating model
    #safe for new users because has_secure_password will still check to make sure they create one
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    # Returns the hash digest of the given string.
  #methods in this block are class methods
  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end


