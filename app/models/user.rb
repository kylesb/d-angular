class User < ActiveRecord::Base
	has_many :lists, dependent: :destroy
	has_many :words, through: :lists

	before_save { self.email = email.downcase }
	
	validates :name, presence: true, length: { maximum: 50 }
	validates :password, length: { minimum: 6 }

	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :email, presence: true, length: { maximum: 255 },
	                format: { with: VALID_EMAIL_REGEX },
	                uniqueness: { case_sensitive: false }
	
	has_secure_password

	# Returns the hash digest of the given string.
	def User.digest(string)
	  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	  BCrypt::Password.create(string, cost: cost)
	end
end