class User < ApplicationRecord
  has_many :posts
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id
  has_many :following, class_name: 'Follow', foreign_key: :follower_id

  validates :username, presence: true, length: { minimum: 3, maximum: 14 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9]*\z/ }
end
