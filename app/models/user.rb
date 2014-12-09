class User < ActiveRecord::Base
	
	include Imageable
	
	has_many :submitted_bands, class_name: "Band", foreign_key: :submitter_id, inverse_of: :submitter
	has_many :submitted_notes, class_name: "Note", foreign_key: :user_id, inverse_of: :author
	
	attr_reader :password # for validating password length
	validates :email, :password_digest, :session_token, presence: true
	validates :email, uniqueness: true
	validates :password, length: { minimum: 6 }, allow_nil: true

	# after User.new or User.find
	after_initialize :ensure_session_token


	def self.generate_session_token
		SecureRandom::urlsafe_base64(16)
	end

	# user_params = {'email' => 'foo', 'password' => 'bar' }
	def self.find_by_credentials(user_params)
		email, password = user_params['email'], user_params['password']
		user = User.find_by(email: email)
		return nil if user.nil?

		user.is_password?(password) ? user : nil
	end

	def reset_session_token!
		self.session_token = User.generate_session_token
		self.save!

		self
	end

	# sets password_digest when User.create(user_params) is called
	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def is_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end


	private

	def ensure_session_token
		self.session_token ||= User.generate_session_token
	end

end
