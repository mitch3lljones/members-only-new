class User < ApplicationRecord
    attr_accessor :remember_token
    before_create :create_remember_token
    
    before_save { self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    has_many :posts

    def User.digest(string)
        Digest::SHA1.hexdigest(string)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def set_new_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
        update_attribute(:remember_digest, User.digest(self.remember_token))
    end

    private
    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
        self.remember_digest = User.digest(self.remember_token)
    end
end
