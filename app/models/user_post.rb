class UserPost < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
end
