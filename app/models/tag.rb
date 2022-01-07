class Tag < ApplicationRecord
  has_many :user_posts, through: :user_post_tags
  has_many :user_post_tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
end
