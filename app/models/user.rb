class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, 
                       length: { maximum: 40 },
                       uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 12 }
  validates :password_confirmation, presence: true
  before_save { email.downcase! }
end
