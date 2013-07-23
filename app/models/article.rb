class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, :content, :user_id, presence: true
  default_scope -> { order('created_at DESC') }
end
