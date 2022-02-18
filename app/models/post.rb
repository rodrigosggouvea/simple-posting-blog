class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Post', optional: true
  # create a standard post by just sending body,
  # a repost by just sending the parent_id,
  # and a quote by sending both parent_id and body

  validates :body, presence: true, if: -> { parent_id.blank? }
  validates :body, length: { maximum: 777 }

  validate :user_post_limit

  scope :today, -> { where('DATE(created_at) = ?', Date.today) }
  scope :by_user, ->(user_id) { where(user: user_id) }

  def user_post_limit
    errors.add(:user, 'users cannot post more than 5 times a day') if Post.by_user(user_id).today.count == 5
  end
end
