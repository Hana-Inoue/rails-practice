class UserPost < ApplicationRecord
  belongs_to :user
  has_many :user_post_comments, dependent: :destroy
  has_many :user_post_tags, dependent: :destroy
  has_many :tags, through: :user_post_tags

  validates :body, presence: true, length: { maximum: 140 }

  def save_user_post_and_tags(new_tag_ids)
    ActiveRecord::Base.transaction do
      save_user_post
      save_user_post_tags(new_tag_ids)
    end
  rescue
    false
  end

  private

  def save_user_post
    self.save!
  end

  def save_user_post_tags(new_tag_ids)
    self.tag_ids = new_tag_ids
  end
end
