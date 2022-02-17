class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 3, maximum: 14 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9]*\z/ }
end
