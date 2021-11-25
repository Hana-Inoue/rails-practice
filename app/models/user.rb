require 'digest/sha2'

class User < ApplicationRecord
  has_many :user_authorizations
  has_many :actions, through: :user_authorizations, dependent: :destroy

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

  def authorized?(action)
    user_authorizations
      .map(&:action_id)
      .include?(Action.find_by(controller: 'user', action: action).id)
  end

  private

  def downcase_email
    email.downcase!
  end
end
