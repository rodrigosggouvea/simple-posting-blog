class Post < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Post'

  validates :body, presence: true, if: -> { parent_id.blank? }
  validates :body, length: { maximum: 777 }
end
