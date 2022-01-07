class UserPostTag < ApplicationRecord
  belongs_to :user_post
  belongs_to :tag

  validates :user_post_id, presence: true
  validates :tag_id, presence: true
end
