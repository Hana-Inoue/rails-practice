class UserPostTag < ApplicationRecord
  belongs_to :user_post
  belongs_to :tag
end
