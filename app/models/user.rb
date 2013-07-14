class User < ActiveRecord::Base
	validates :username, presence: true, length: { maximum: 40 }
	validates :email, presence: true
end
