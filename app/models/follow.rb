class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validate :self_follow

  def self_follow
    errors.add(:followed, 'users cannot follow themselves') if follower == followed
  end
end
