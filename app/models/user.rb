class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  
  has_secure_password
  validates :username, presence: true, 
                       length: { maximum: 40 },
                       uniqueness: { case_sensitive: false }
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL }
  validates :password, length: { minimum: 12 }
  validates :password_confirmation, presence: true
  before_save { email.downcase! }
  before_save :create_remember_token

 private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
