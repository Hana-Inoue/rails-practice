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
  validates :password_confirmation, presence: true

  before_save :downcase_email, :password_digest

  def valid_password?(password)
    self.password == digest(password)
  end

  private

  def downcase_email
    email.downcase!
  end

  def password_digest
    self.password = digest(self.password)
  end

  def digest(string)
    Digest::SHA256.hexdigest(string)
  end
end
