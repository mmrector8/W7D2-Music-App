class User < ApplicationRecord
    before_validation :ensure_session_token
    attr_reader :password
    validates :email, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 8, allow_nil: true}

    #SPIRE
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            render user
        else
            render nil 
        end

    end

    def password=(password)
        @password = password
        self.password_digest = BCrpyt::Password.create(password)
    end

    def is_password?(password)
       b_crypt = BCrypt::Password.new(self.password_digest)
       b_crypt.is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    private
    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def generate_unique_session_token
        token = RandomSecure::urlsafe_base64
        if User.exists?(session_token: token)
            token = RandomSecure::urlsafe_base64
        end
    end
end
