class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  GENDERS_IN_JAPANESE = { men: '男性', women: '女性', others: 'その他' }

  enum gender: {
    men: 0,
    women: 1,
    others: 2
  }

  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :birthday
  end
  validates :gender, inclusion: { in: genders.keys }

  before_save { downcase_email }

  def gender_in_japanese
    GENDERS_IN_JAPANESE[gender.to_sym]
  end

  private

  def downcase_email
    email.downcase!
  end
end
