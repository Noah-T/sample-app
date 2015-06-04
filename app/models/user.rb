class User < ActiveRecord::Base
	#force email to save as all lowercase 
	before_save { self.email = email.downcase }
	#name must be present
	validates :name, presence: true, length: { maximum: 50}
	#capital letters indicate constant
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }

    has_secure_password
end
