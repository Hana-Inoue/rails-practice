require 'digest/sha2'

class User < ApplicationRecord
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
  # TODO: エラーメッセージが適切な内容になるよう修正
  validates :password_confirmation, presence: true

  before_save { downcase_email }

  # TODO: 呼び出し元の実装
  def password_digest
    password = Digest::SHA256.hexdigest(password)
  end

  private

  def downcase_email
    email.downcase!
  end
end
