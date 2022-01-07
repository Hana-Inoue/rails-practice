class UserPost < ApplicationRecord
  belongs_to :user
  has_many :user_post_comments, dependent: :destroy
  has_many :tags, through: :user_post_tags
  has_many :user_post_tags, dependent: :destroy

  validates :body, presence: true, length: { maximum: 140 }
end
