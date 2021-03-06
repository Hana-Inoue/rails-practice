require 'digest/sha2'

class User < ApplicationRecord
  has_many :user_authorizations
  has_many :authorizations, through: :user_authorizations, dependent: :destroy
  has_many :user_diaries, dependent: :destroy
  has_many :user_posts, dependent: :destroy
  has_one :user_address, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum gender: {
    men: 0,
    women: 1,
    others: 2
  }

  validates :name, presence: true, length: { maximum: 30 }
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :gender, inclusion: { in: genders.keys }
  validates :birthday, presence: true
  validates :password, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  before_save :downcase_email

  has_secure_password

  def authorized?(controller, action)
    authorizations.any? do |authorization|
      authorization.controller == controller && authorization.action == action
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
