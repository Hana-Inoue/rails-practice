require 'digest/sha2'

class User < ApplicationRecord
  has_many :user_authorizations
  has_many :authorizations, through: :user_authorizations, dependent: :destroy

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

  def update_user_authorizations(authorization_ids)
    ActiveRecord::Base.transaction do
      delete_user_authorizations
      add_user_authorizations(authorization_ids)
    end
  rescue
    return false
  end

  private

  def downcase_email
    email.downcase!
  end

  def delete_user_authorizations
    user_authorizations.destroy_all
  end

  def add_user_authorizations(authorization_ids)
    authorization_ids.each do |authorization_id|
      ControllerAction.find_by(id: authorization_id).users << self
    end
  end
end
